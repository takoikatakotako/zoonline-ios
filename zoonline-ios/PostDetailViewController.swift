import UIKit
import Social
import FirebaseAuth
import FirebaseStorage
import FirebaseUI
import SCLAlertView

class PostDetailViewController: UIViewController {

    private var isSignIn = false
    private var uid: String?

    private var postDetailView: PostDetailView!

    private var postDetailTableView: UITableView!

    private var comments: [Comment] = []

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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // 投稿
        postDetailView = PostDetailView(post: post)
        postDetailView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: postDetailView.calcHeight(viewWidth: view.frame.width))

        // ボタンアクションの設定
        postDetailView.followButton.addTarget(self, action: #selector(followButtonTouched(sender:)), for: .touchUpInside)
        postDetailView.userInfoButton.addTarget(self, action: #selector(userInfoButtonTouched(sender:)), for: .touchUpInside)
        postDetailView.favoriteButton.addTarget(self, action: #selector(favoriteButtonTouched(sender:)), for: .touchUpInside)
        postDetailView.commentButton.addTarget(self, action: #selector(commentButtonTouched(sender:)), for: .touchUpInside)

        //テーブルビューの初期化
        postDetailTableView = UITableView()
        postDetailTableView.delegate = self
        postDetailTableView.dataSource = self
        postDetailTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(CommentTableViewCell.self))
        postDetailTableView.tableHeaderView = postDetailView
        postDetailTableView.rowHeight = 100
        view.addSubview(postDetailTableView)

        //
        Comment.featchComments(postId: post.postId) { (comments, error) in
            if let error = error {
                print(error)
                return
            }
            self.comments = comments
            self.postDetailTableView.reloadData()
        }
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

            if uid == post.uid {
                return
            }

            // フォローしているか取得する
            Follow.isFollow(uid: uid, followUid: post.uid, completion: { (isFollow, err) in
                if let err = err {
                    self.showErrorAlert(message: err.description)
                    return
                }
                if isFollow {
                    self.postDetailView.followButton.setFollow()
                } else {
                    self.postDetailView.followButton.setUnFollow()
                }
            })

            // コメント済みか調べる
            CommentHandler.didComment(uid: uid, postId: post.postId) { (didComment, error) in
                if let error = error {
                    self.showErrorAlert(message: error.description)
                    return
                }
                if didComment {
                    self.postDetailView.commentButton.backgroundColor = .red
                } else {

                }
            }

        } else {
            // No user is signed in
            isSignIn = false
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        postDetailTableView.frame = view.frame
    }

    // MARK: Button Actions
    @objc func userInfoButtonTouched(sender: UIButton) {
        // ユーザー詳細画面へ
        let userInfoViewController = UserInfoViewController(uid: post.uid)
        navigationController?.pushViewController(userInfoViewController, animated: true)
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
            self.postDetailView.followButton.setUnFollow()
            Follow.unFollow(uid: uid, followUid: post.uid, completion: { error in
                if let error = error {
                    self.showErrorAlert(message: error.description)
                    // 状態を元に戻す
                    self.postDetailView.followButton.setFollow()
                    return
                }
            })
        } else {
            // フォローする
            self.postDetailView.followButton.setFollow()
            Follow.follow(uid: uid, followUid: post.uid, completion: { error in
                if let error = error {
                    self.showErrorAlert(message: error.description)
                    // 状態を元に戻す
                    self.postDetailView.followButton.setUnFollow()
                    return
                }
            })
        }
    }

    @objc func favoriteButtonTouched(sender: UIButton) {
        // お気に入り
        postDetailView.favoriteButton.setFavorite()
    }

    @objc func commentButtonTouched(sender: UIButton) {
        // コメント投稿へ
        guard let uid = uid else {
            print("ログイン必須")
            return
        }
        let postCommentViewController = PostCommentViewController(uid: uid, postId: post.postId)
        navigationController?.pushViewController(postCommentViewController, animated: true)
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let uid = comment.uid
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CommentTableViewCell.self)) as! CommentTableViewCell
        cell.commentTextView.text = comment.comment
        UserHandler.featchUser(uid: uid) { (user, error) in
            if let error = error {
                self.showErrorAlert(message: error.description)
                return
            }
            cell.userName.text = user?.nickname
            cell.dateLabel.text = comment.date
        }
        cell.thumbnail.sd_setImage(with: User.getIconReference(uid: uid), placeholderImage: UIImage(named: "common-icon-default"))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommentTableViewCell.calcHeight(viewWidth: view.frame.width, comments: comments[indexPath.row].comment)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let comment = comments[indexPath.row]
        guard let uid = uid, uid == comment.uid else {
            navigationController?.pushViewController(UserInfoViewController(uid: comment.uid), animated: true)
            return
        }
        showErrorAlert(message: "自分のコメントです。")
    }
}
