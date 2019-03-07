import UIKit
import Firebase

class MyPostsViewController: UIViewController {

    //UserInfo
    private var uid: String!
    private var myPostsCollectionView: UICollectionView!
    private var posts: [Post]?

    init(uid: String) {
        self.uid = uid
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // コレクションビューの初期化
        let collectionFrame = view.frame
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

        PostHandler.featchUserPosts(uid: uid) { (posts, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            self.posts = posts
            self.myPostsCollectionView.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        myPostsCollectionView.frame = view.frame
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
}

extension MyPostsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let posts = self.posts else {
            return
        }
        let postDetail = PostDetailViewController(post: posts[indexPath.row])
        navigationController?.pushViewController(postDetail, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let posts = self.posts else {
            return 30
        }
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PostsCollectionViewCell.self), for: indexPath) as! PostsCollectionViewCell
        guard let posts = self.posts else {
            cell.imageView.image = UIImage(named: "no_img")
            return cell
        }

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let postId = posts[indexPath.section * 6 + indexPath.row].id!
        let reference = storageRef.child(Post.getPostImagePath(postId: postId))
        cell.imageView?.sd_setImage(with: reference, placeholderImage: UIImage(named: "no_img"))
        return cell
    }
}
