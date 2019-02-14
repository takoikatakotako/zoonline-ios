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
        let reference = storageRef.child("user/" + String(uid) + "/icon.png")
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error)
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                self.userInfoView.userThumbnail.image = image
            }
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
