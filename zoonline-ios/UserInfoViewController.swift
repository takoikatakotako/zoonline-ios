import UIKit

class UserInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //UserInfo
    var postUserID: Int!

    private var profileCollectionView: UICollectionView!
    private var userInfoView: UserInfoCollectionReusableView!

    private var myItems: Array<String> = ["天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
    "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
    "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
    "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
    "天王寺動物園"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton

        // ユーザー情報
        userInfoView = UserInfoCollectionReusableView()
        userInfoView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 260)

        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width/3, height: view.frame.width/3)
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        profileCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        profileCollectionView?.register(UserInfoCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(UserInfoCollectionReusableView.self))
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
    // Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postDetail: PostDetailViewController = PostDetailViewController()
        navigationController?.pushViewController(postDetail, animated: true)
    }

    // Cellの総数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }

    // Cellに値を設定する
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
