import UIKit
import Firebase

class UserInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //UserInfo
    private var uid: String!

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

        // icon
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child(User.getUserIconPath(uid: uid))
         self.userInfoView.userThumbnail.sd_setImage(with: reference, placeholderImage: UIImage(named: "common-icon-default"))

        UserHandler.featchUser(uid: uid) { (user, error) in
            if let error = error {
                self.showMessageAlert(message: error.description)
                return
            }
            self.userInfoView.userName.text = user?.nickname
            self.userInfoView.userDescription.text = user?.profile

        }

        let db = Firestore.firestore()
        let docRef = db.collection("user").document(String(uid))
        docRef.getDocument { (document, _) in
            if let document = document, document.exists {
                if let data = document.data() {
                    if let name = data["name"] as? String {
                        self.userInfoView.userName.text = name
                    }
                    if let profile = data["profile"] as? String {
                        self.userInfoView.userDescription.text = profile
                    }
                }
            } else {
                print("Document does not exist")
            }
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
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.frame.width
        let height = view.frame.height
        profileCollectionView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }

    // MARK: CollectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postDetail: PostDetailViewController = PostDetailViewController(post: Post())
        navigationController?.pushViewController(postDetail, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PostsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PostsCollectionViewCell.self), for: indexPath) as! PostsCollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return userInfoView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(UserInfoCollectionReusableView.self), for: indexPath)
        header.addSubview(userInfoView)
        return header
    }
}
