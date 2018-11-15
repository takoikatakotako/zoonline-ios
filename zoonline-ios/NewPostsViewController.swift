import UIKit
import SCLAlertView
import Alamofire
import SwiftyJSON
import SDWebImage

protocol NewPostsDelegate: class  {
    func goDetailView(postID:Int)
    func startIndicator()
    func stopIndicator()
}

class NewPostsViewController: CustumViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //delegate
    weak var delegate: NewPostsDelegate?
    
    //width, height
    var pageMenuHeight:CGFloat!
    private var collectionViewHeight:CGFloat!
    
    //APIから取得したデーター
    var newContents:JSON = []
    var isNetWorkConnect:Bool = true
    
    //CollectionViews
    var newCollectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageName = PageName.Field.rawValue
        
        //画面横サイズを取得
        self.viewWidth = self.view.frame.width
        self.viewHeight = self.view.frame.height
        self.collectionViewHeight = viewHeight - (statusBarHeight + navigationBarHeight + pageMenuHeight + tabBarHeight)

        setCollectionView()
        getNewContents()
    }
    
    func getNewContents(){
        
        Alamofire.request(EveryZooAPI.getRecentPosts()).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                //NetWork False -> true
                if !self.isNetWorkConnect{
                    self.setFieldCollection()
                }
                self.isNetWorkConnect = true
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                self.newContents = json

            case .failure(let error):
                print(error)
                //NetWork True -> False
                if self.isNetWorkConnect{
                    self.setNetWorkErrorCollection()
                }
                self.isNetWorkConnect = false
                self.newContents = []
            }
            
            self.delegate?.stopIndicator()
            self.newCollectionView.refreshControl?.endRefreshing()
            self.newCollectionView.reloadData()
        }
    }

    // MARK: - Viewにパーツの設置
    func setCollectionView(){

        let collectionFrame = CGRect(x: 0, y: 0, width: viewWidth, height: collectionViewHeight)
        let layout = FieldCollectionViewFlowLayout()
        newCollectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        newCollectionView.backgroundColor = UIColor.white
        newCollectionView.register(FieldCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(FieldCollectionViewCell.self))
        newCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        newCollectionView.register(NetWorkErrorCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(NetWorkErrorCollectionViewCell.self))
        newCollectionView.delegate = self
        newCollectionView.dataSource = self
        if #available(iOS 11.0, *) {
            newCollectionView.contentInsetAdjustmentBehavior = .never
        }
        
        //リフレッシュコントロールの追加
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: .valueChanged)
        newCollectionView.refreshControl = refreshControl
        self.view.addSubview(newCollectionView)
    }
    
    func setFieldCollection(){
        newCollectionView.collectionViewLayout.invalidateLayout()
        let layout = FieldCollectionViewFlowLayout()
        newCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func setNetWorkErrorCollection(){
        
        newCollectionView.collectionViewLayout.invalidateLayout()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:viewWidth, height:collectionViewHeight)
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.headerReferenceSize = CGSize(width:0,height:0)
        newCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    @objc func scrollReflesh(sender : UIRefreshControl) {
        getNewContents()
    }
    
    //Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !isNetWorkConnect { return }
        print("Section: \(indexPath.section)")
        print("Num: \(indexPath.row)")
        print("Number: \(indexPath.section * 6 + indexPath.row)")
        
        delegate?.goDetailView(postID: self.newContents[indexPath.section * 6 + indexPath.row]["id"].intValue)
    }
    
    //セクションあたりのセルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if !isNetWorkConnect {
            return 1
        }
        
        return 6
    }
    //セクションの総数を返す
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if !isNetWorkConnect {
            return 1
        }
        return newContents.count / 6
    }
    //Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if !isNetWorkConnect {
            let cell:NetWorkErrorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:  NSStringFromClass(NetWorkErrorCollectionViewCell.self), for: indexPath as IndexPath) as! NetWorkErrorCollectionViewCell
            return cell
        }
        
        let cell:FieldCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:  NSStringFromClass(FieldCollectionViewCell.self), for: indexPath as IndexPath) as! FieldCollectionViewCell
        if let thumbnailUrl = URL(string:newContents[indexPath.section * 6 + indexPath.row]["itemImage"].stringValue){
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 16
            cell.thumbnailImgView?.sd_setImage(with: thumbnailUrl, placeholderImage: UIImage(named: "no_img"))
        }
        return cell
    }
}
