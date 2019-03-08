import UIKit
import Firebase

class UserInfoViewController: UIViewController {

    //UserInfo
    private var uid: String!
    private var posts: [Post] = []

    private var profileCollectionView: UICollectionView!
    private var userInfoView: UserInfoCollectionReusableView!

    init(uid: String) {
        self.uid = uid
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton

        // ユーザー情報
        userInfoView = UserInfoCollectionReusableView()
        userInfoView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 260)
        userInfoView.userThumbnail.sd_setImage(with: User.getIconReference(uid: uid), placeholderImage: UIImage(named: "common-icon-default"))
        UserHandler.featchUser(uid: uid) { (user, error) in
            if let error = error {
                self.showMessageAlert(message: error.description)
                return
            }
            self.userInfoView.userName.text = user?.nickname
            self.userInfoView.userDescription.text = user?.profile
        }

        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width/3, height: view.frame.width/3)
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        profileCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        profileCollectionView.backgroundColor = UIColor(named: "backgroundGray")
        profileCollectionView.register(UserInfoCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(UserInfoCollectionReusableView.self))
        profileCollectionView.register(PostsCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(PostsCollectionViewCell.self))
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.backgroundColor = UIColor.white
        view.addSubview(profileCollectionView)

        PostHandler.featchUserPosts(uid: uid) { (posts, error) in
            if let error = error {
                self.showMessageAlert(message: error.description)
                return
            }
            self.posts = posts
            self.profileCollectionView.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileCollectionView.frame = view.frame
    }
}

extension UserInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(UserInfoCollectionReusableView.self), for: indexPath)
        header.addSubview(userInfoView)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postDetail: PostDetailViewController = PostDetailViewController(post: posts[indexPath.row])
        navigationController?.pushViewController(postDetail, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PostsCollectionViewCell.self), for: indexPath) as! PostsCollectionViewCell
        cell.imageView.sd_setImage(with: posts[indexPath.row].imageReference, placeholderImage: UIImage(named: "sample-postImage"))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return userInfoView.frame.size
    }
}
