import UIKit
import Firebase

class FavoritePostsViewController: UIViewController {

    private var uid: String!
    private var myPostsCollectionView: UICollectionView!
    private var favorites: [Favorite] = []

    init(uid: String) {
        self.uid = uid
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "おきにいり"
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

        FavoriteHandler.featchFavorite(uid: uid) { (favorites, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            print(favorites.count)
            self.favorites = favorites
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

extension FavoritePostsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let post = PostHandler.featchPost(postId: favorite.postId) { (post, error) in
            if let error = error {
                self.showMessageAlert(message: error.description)
                return
            }
            let postDetail = PostDetailViewController(post: post)
            self.navigationController?.pushViewController(postDetail, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PostsCollectionViewCell.self), for: indexPath) as! PostsCollectionViewCell
        let favorite = favorites[indexPath.row]
        cell.imageView?.sd_setImage(with: favorite.postImageReference, placeholderImage: UIImage(named: "no_img"))
        return cell
    }
}
