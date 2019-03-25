import UIKit
import Firebase
import FirebaseStorage

class FieldViewController: UIViewController {

    var uid: String?

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

        let layout = FieldCollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(FieldCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(FieldCollectionViewCell.self))
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        collectionView.register(NetWorkErrorCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(NetWorkErrorCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.collectionViewLayout.invalidateLayout()
        let layout2 = FieldCollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(layout2, animated: false)
        view.addSubview(collectionView)

        postButton = UIButton()
        postButton.backgroundColor = UIColor(named: "main")
        postButton.layer.cornerRadius = 40
        postButton.setImage(UIImage(named: "field-add"), for: .normal)
        postButton.addTarget(self, action: #selector(postBtnTapped), for: .touchUpInside)
        postButton.layer.shadowOpacity = 0.5
        postButton.layer.shadowRadius = 12
        postButton.layer.shadowColor = UIColor.black.cgColor
        postButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.addSubview(postButton)

        //リフレッシュコントロールの追加
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl

        featchPosts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false

        if let user = Auth.auth().currentUser {
            // User is signed in
            uid = user.uid
        } else {
            uid = nil
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let width = view.frame.width
        let height = view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)
        let collectionFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)

        postButton.frame = CGRect(x: width - 100, y: height - 100, width: 80, height: 80)
        collectionView.frame = collectionFrame
    }

    func featchPosts() {
        PostHandler.featchNesPosts(limit: 50) { (posts, error) in
            if let error = error {
                self.showMessageAlert(message: error.description)
                return
            }
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }

    @objc func scrollReflesh(sender: UIRefreshControl) {
        featchPosts()
    }

    @objc func postBtnTapped() {
        if uid == nil {
            showLoginAlert()
        } else {
            let postNavigationController = UINavigationController(rootViewController: PostViewController())
            present(postNavigationController, animated: true, completion: nil)
        }
    }

    func showLoginAlert() {
        let actionAlert = UIAlertController(title: "", message: "投稿機能を使うにはログインが必要です", preferredStyle: UIAlertController.Style.alert)
        let kabigonAction = UIAlertAction(title: "ログイン", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
            // TODO: ログイン関係
            print("ログイン")
        })
        actionAlert.addAction(kabigonAction)

        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        actionAlert.addAction(cancelAction)

       present(actionAlert, animated: true, completion: nil)
    }
}

extension FieldViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //画面遷移、投稿詳細画面へ
        let picDetailView: PostDetailViewController = PostDetailViewController(post: posts[indexPath.section * 6 + indexPath.row])
        picDetailView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(picDetailView, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return posts.count / 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FieldCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(FieldCollectionViewCell.self), for: indexPath as IndexPath) as! FieldCollectionViewCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 16
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child("post/" + posts[indexPath.section * 6 + indexPath.row].postId + "/image.png")
        cell.thumbnailImgView?.sd_setImage(with: reference, placeholderImage: UIImage(named: "no_img"))
        return cell
    }
}
