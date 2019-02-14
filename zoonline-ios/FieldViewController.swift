import UIKit
import Firebase
import FirebaseStorage
class FieldViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //CollectionViews
    var collectionView: UICollectionView!
    var postButton: UIButton!

    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton

        //ナビゲーションアイテムを作成
        title = "ひろば"

        let db = Firestore.firestore()
        db.collection("post").order(by: "created_at", descending: true).limit(to: 50).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let post = Post(id: document.documentID, data: document.data())
                    self.posts.append(post)
                }
                self.collectionView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.frame.width
        let height = view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)
        let collectionFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        let layout = FieldCollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(FieldCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(FieldCollectionViewCell.self))
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        collectionView.register(NetWorkErrorCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(NetWorkErrorCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        view.addSubview(collectionView)

        //リフレッシュコントロールの追加
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl

        collectionView.collectionViewLayout.invalidateLayout()
        let layout2 = FieldCollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(layout2, animated: false)

        postButton = UIButton()
        postButton.backgroundColor = UIColor(named: "main")
        postButton.frame = CGRect(x: width - 100, y: height - 100, width: 80, height: 80)
        postButton.layer.cornerRadius = 40
        postButton.setImage(UIImage(named: "field-add"), for: .normal)
        postButton.addTarget(self, action: #selector(showPostVC(sender:)), for: .touchUpInside)
        view.addSubview(postButton)
    }

    @objc func scrollReflesh(sender: UIRefreshControl) {
    }

    @objc func showPostVC(sender: UIRefreshControl) {
        let postNavigationController = UINavigationController(rootViewController: PostViewController())
        self.present(postNavigationController, animated: true, completion: nil)
    }

    //Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section: \(indexPath.section)")
        print("Num: \(indexPath.row)")
        print("Number: \(indexPath.section * 6 + indexPath.row)")

        //画面遷移、投稿詳細画面へ
        let picDetailView: PostDetailViewController = PostDetailViewController(post: posts[indexPath.row])
        picDetailView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(picDetailView, animated: true)
    }

    //セクションあたりのセルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    //セクションの総数を返す
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return posts.count / 6
    }

    //Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FieldCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(FieldCollectionViewCell.self), for: indexPath as IndexPath) as! FieldCollectionViewCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 16
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child("post/" + posts[indexPath.row].id + "/image.png")
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error)
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                cell.thumbnailImgView?.image = image
            }
        }
        cell.thumbnailImgView?.image = UIImage(named: "no_img")

        return cell
    }
}
