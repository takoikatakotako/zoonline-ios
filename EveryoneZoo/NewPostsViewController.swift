//
//  NewPostsViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/13.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

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
            
            self.delegate?.stopIndicator()
            
            switch response.result {
            case .success:
                self.isNetWorkConnect = true
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                
                self.newContents = json
            case .failure(let error):
                print(error)
                self.isNetWorkConnect = false
            }
            
            //テーブルの再読み込み
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
        
        newCollectionView.delegate = self
        newCollectionView.dataSource = self
        if #available(iOS 11.0, *) {
            newCollectionView.contentInsetAdjustmentBehavior = .never
        }
        self.view.addSubview(newCollectionView)
    }
    
    
    
    //Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section: \(indexPath.section)")
        print("Num: \(indexPath.row)")
        print("Number: \(indexPath.section * 6 + indexPath.row)")
        
        delegate?.goDetailView(postID: self.newContents[indexPath.section * 6 + indexPath.row]["id"].intValue)

    }
    
    //セクションあたりのセルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    //セクションの総数を返す
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return newContents.count / 6
    }
    //Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : FieldCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:  NSStringFromClass(FieldCollectionViewCell.self), for: indexPath as IndexPath) as! FieldCollectionViewCell
        if let thumbnailUrl = URL(string:newContents[indexPath.section * 6 + indexPath.row]["itemImage"].stringValue){
          
            cell.thumbnailImgView?.sd_setImage(with: thumbnailUrl, placeholderImage: UIImage(named: "no_img"))
        }

        return cell
    }
}
