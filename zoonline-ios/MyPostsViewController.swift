import UIKit
import Firebase
import FirebaseAuth
import Alamofire
import SwiftyJSON
import SDWebImage
import SCLAlertView

class MyPostsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //UserInfo
    private var uid: String!
    var myPostsCollectionView: UICollectionView!
    private var frindsList: JSON = []
    private var posts: [Post] = []

    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()

    init(uid: String) {
        self.uid = uid
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        view.backgroundColor = .white
        //テーブルビューの初期化
        let collectionFrame = view.frame

        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width/3, height: view.frame.width/3)
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        myPostsCollectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        myPostsCollectionView.register(PostsCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(PostsCollectionViewCell.self))
        myPostsCollectionView.delegate = self
        myPostsCollectionView.dataSource = self
        myPostsCollectionView.backgroundColor = UIColor.white
        view.addSubview(myPostsCollectionView)

        let db = Firestore.firestore()
        db.collection("post").whereField("uid", isEqualTo: uid).order(by: "created_at", descending: true).limit(to: 50).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let post = Post(id: document.documentID, data: document.data())
                    self.posts.append(post)
                }
                self.myPostsCollectionView.reloadData()
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.frame.width
        let height = view.frame.height
        myPostsCollectionView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    // MARK: くるくるの生成
    func setActivityIndicator() {

        // indicator.frame = CGRect(x: viewWidth*0.35, y: viewHeight*0.25, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.clipsToBounds = true
        // indicator.layer.cornerRadius = viewWidth*0.3*0.3
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        view.bringSubviewToFront(indicator)
        indicator.color = UIColor.init(named: "main")
        view.addSubview(indicator)
    }

    // MARK: テーブルビューのセルの数を設定する
    // Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //画面遷移、ユーザー情報画面へ
        let postDetail: PostDetailViewController = PostDetailViewController(post: posts[indexPath.row])
        self.navigationController?.pushViewController(postDetail, animated: true)
    }

    // Cellの総数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    // Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PostsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PostsCollectionViewCell.self), for: indexPath) as! PostsCollectionViewCell
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child("post/" + posts[indexPath.section * 6 + indexPath.row].id + "/image.png")
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        reference.getData(maxSize: 2 * 2048 * 2048) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error)
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                cell.imageView?.image = image
            }
        }
        cell.imageView?.image = UIImage(named: "no_img")
        return cell
    }
}
