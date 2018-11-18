import UIKit

class FieldVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //CollectionViews
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //ナビゲーションアイテムを作成
        let titleLabel: NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: view.frame.width * 0.3, y: 0, width: view.frame.width * 0.4, height: 40)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "ひろば"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)
        let collectionFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        let layout = FieldCollectionViewFlowLayout()
        collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(FieldCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(FieldCollectionViewCell.self))
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        collectionView.register(NetWorkErrorCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(NetWorkErrorCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never

        //リフレッシュコントロールの追加
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        self.view.addSubview(collectionView)

        collectionView.collectionViewLayout.invalidateLayout()
        let layout2 = FieldCollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(layout2, animated: false)
    }

    @objc func scrollReflesh(sender: UIRefreshControl) {

    }

    //Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section: \(indexPath.section)")
        print("Num: \(indexPath.row)")
        print("Number: \(indexPath.section * 6 + indexPath.row)")

        //画面遷移、投稿詳細画面へ
        let picDetailView: PostDetailVC = PostDetailVC()
        //picDetailView.postID = 0
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }

    //セクションあたりのセルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    //セクションの総数を返す
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    //Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FieldCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(FieldCollectionViewCell.self), for: indexPath as IndexPath) as! FieldCollectionViewCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 16
        cell.thumbnailImgView?.image = UIImage(named: "no_img")
        return cell
    }
}
