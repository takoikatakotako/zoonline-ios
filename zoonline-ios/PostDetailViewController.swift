import UIKit
import Social
import FirebaseAuth
import FirebaseStorage
import Alamofire
import SwiftyJSON
import SCLAlertView
import SDWebImage

class PostDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var isSignIn = false
    private var uid: String?

    private var postDetailView: PostDetailView!

    private var postDetailTableView: UITableView!

    private var myItems: [String] = []

    private let post: Post!

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton

        myItems = ["天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
            "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
            "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
            "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
            "天王寺動物園"]

        // 投稿
        postDetailView = PostDetailView(post: post)
        postDetailView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: postDetailView.calcHeight(viewWidth: view.frame.width))

        // ボタンアクションの設定
        postDetailView.followButton.addTarget(self, action: #selector(followButtonTouched(sender:)), for: .touchUpInside)
        postDetailView.userInfoButton.addTarget(self, action: #selector(userInfoButtonTouched(sender:)), for: .touchUpInside)
        postDetailView.commentButton.addTarget(self, action: #selector(commentButtonTouched(sender:)), for: .touchUpInside)

        //
        fetchImage()

        //テーブルビューの初期化
        postDetailTableView = UITableView()
        postDetailTableView.delegate = self
        postDetailTableView.dataSource = self
        postDetailTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(CommentTableViewCell.self))
        postDetailTableView.tableHeaderView = postDetailView
        postDetailTableView.rowHeight = 100
        view.addSubview(postDetailTableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = Auth.auth().currentUser {
            // User is signed in
            uid = user.uid
            isSignIn = true

            guard let uid = uid else {
                return
            }

            // フォローしているか取得する
            Follow.isFollow(uid: uid, followUid: post.uid, completion: { (isFollow, err) in
                if let err = err {
                    print("フォロー情報の取得に失敗しました")
                    print(err.description)
                }

                if isFollow {
                    print("フォローしてます")
                    self.postDetailView.followButton.setFollow()
                } else {
                    print("フォローしてません")
                    self.postDetailView.followButton.setUnFollow()
                }
            })
        } else {
            // No user is signed in
            isSignIn = false
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.frame.width
        let height = view.frame.height
        // let height = view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)
        postDetailTableView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }

    // MARK: Fetch FireBase
    func fetchImage() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child("post/" + post.id + "/image.png")
        self.postDetailView.postImage.sd_setImage(with: reference, placeholderImage: UIImage(named: "no_img"))
    }

    // MARK: Button Actions
    @objc func userInfoButtonTouched(sender: UIButton) {
        // ユーザー詳細画面へ
        let userInfoViewController = UserInfoViewController(uid: post.uid)
        self.navigationController?.pushViewController(userInfoViewController, animated: true)
    }

    @objc func commentButtonTouched(sender: UIButton) {
        // コメント投稿へ
        let postCommentViewController = PostCommentViewController()
        self.navigationController?.pushViewController(postCommentViewController, animated: true)
    }

    @objc func followButtonTouched(sender: UIButton) {
        print("basicButtonBtnClicked")
        guard let uid = uid else {
            print("ログインが必要です")
            return
        }

        guard let isFollow = postDetailView.followButton.isFollow else {
            print("フェッチ中です")
            return
        }

        if isFollow {
            // フォロー解除する

        } else {
            // フォローする
            Follow.follow(uid: uid, followUid: post.uid, error: { error in
                if let error = error {
                    let alert = UIAlertController(title: "エラー", message: error.description, preferredStyle: UIAlertController.Style.alert)
                    let cancelAction = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                // フォロー成功
                print("フォローしてます")
                self.postDetailView.followButton.setFollow()
            })
        }
    }

    // MARK: TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return myItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CommentTableViewCell.self))! as! CommentTableViewCell
        cell.commentTextView.text = myItems[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommentTableViewCell.calcHeight(viewWidth: view.frame.width, comments: myItems[indexPath.row])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
}
