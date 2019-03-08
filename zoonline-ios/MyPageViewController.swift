import UIKit
import Social
import Firebase
import FirebaseAuth
import GoogleSignIn
import SCLAlertView

class MyPageViewController: UIViewController, GIDSignInUIDelegate {

    var uid: String!

    // Sign In
    var signInSection: [String] = ["ユーザー情報", "設定・その他", "ログアウト"]
    var signInUserInfoTitle: [String] = ["投稿", "フォロイー", "フォロワー", "お気に入り"]
    var signInUserInfoIcon: [String] = ["mypage_post", "mypage_friends", "mypage_follower", "mypage_favorite"]
    var signInConfigTitle: [String] = ["お問い合わせ", "シェア", "利用規約", "プライバシーポリシー"]
    var signInConfigIcon: [String] = ["mypage_contact", "mypage_share", "mypage_info", "mypage_caution"]
    var signInLogoutTitle: [String] = ["ログアウト"]
    var signInLogoutIcon: [String] = ["mypage_logout"]

    // Sign Out
    var signOutSection: [String] = ["設定・その他", "ログイン"]
    var signOutConfigTitle: [String] = ["お問い合わせ", "シェア", "利用規約", "プライバシーポリシー"]
    var signOutConfigIcon: [String] = ["mypage_contact", "mypage_share", "mypage_info", "mypage_caution"]
    var signOutLoginTitle: [String] = ["ログイン"]
    var signOutLoginIcon: [String] = ["mypage_logout"]

    // ユーザー情報
    private var userHeaderView: MyPageUserHeaderView!

    //テーブルビューインスタンス
    private var myPageTableView: UITableView!

    // Sectionで使用する配列を定義する.
    override func viewDidLoad() {
        super.viewDidLoad()

        //isSignIn = appDelegate.userDefaultsManager?.isSignIn()
        GIDSignIn.sharedInstance().uiDelegate = self

        title = "マイページ"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // header
        userHeaderView = MyPageUserHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        userHeaderView.backgroundColor = UIColor.white
        userHeaderView.addTarget(self, action: #selector(MyPageViewController.goMyProfile(sender:)), for: .touchUpInside)
        userHeaderView.iconImgView.image = UIImage(named: "common-icon-default")

        // table
        myPageTableView = UITableView(frame: view.frame, style: UITableView.Style.grouped)
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
        myPageTableView.backgroundColor = UIColor(named: "backgroundGray")
        myPageTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MyPageTableViewCell.self))
        myPageTableView.rowHeight = 48
        myPageTableView.tableHeaderView = userHeaderView
        view.addSubview(myPageTableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let user = Auth.auth().currentUser {
            // User is signed in
            uid = user.uid
            setUserIcon(uid: user.uid)
            setNickname(uid: user.uid)
            userHeaderView.userMailAdressLabel.text = user.email
            myPageTableView.reloadData()
        } else {
            // No user is signed in
            uid = nil
            userHeaderView.userNameLabel.text = "未ログイン"
            userHeaderView.userMailAdressLabel.text = "ログインしてください"
            userHeaderView.iconImgView.image = UIImage(named: "common-icon-default")
            myPageTableView.reloadData()
        }
    }

    func setNickname(uid: String) {
        UserHandler.featchUser(uid: uid) { (user, error) in
            if let error = error {
                self.showMessageAlert(message: error.description)
                return
            }
            self.userHeaderView.userNameLabel.text = user?.nickname
        }
    }

    func setUserIcon(uid: String) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child("user/" + String(uid) + "/icon.png")
        self.userHeaderView.iconImgView.sd_setImage(with: reference, placeholderImage: UIImage(named: "common-icon-default"))
    }

    // MARK: Actions
    @objc func goMyProfile(sender: UIButton) {
        if uid != nil {
            let myProfilelViewController = MyProfilelViewController()
            myProfilelViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(myProfilelViewController, animated: true)
        } else {
            showConfirmAlert()
        }
    }

    func goMyPosts() {
        // My Posts List
        let vc = MyPostsViewController(uid: uid)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    func goMyFriends() {
        // Friends List
        let vc = FolloweeViewController(uid: uid)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    func goMyFollows() {
        // Follower List
        let vc = FollowerViewController(uid: uid)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    func goMyFavorites() {
        // My Favorites List
        let vc = MyFavoritePostsViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    func openWebView(navTitle: String, url: String) {
        // Term of Service
        let contactView: WebViewController = WebViewController()
        contactView.url = url
        contactView.navTitle = navTitle
        contactView.view.backgroundColor = .white
        present(UINavigationController(rootViewController: contactView), animated: true, completion: nil)
    }

    func showConfirmAlert() {
        let alert = UIAlertController(title: "", message: "Googleログインが必要です", preferredStyle: UIAlertController.Style.alert)
        let signInAction = UIAlertAction(title: "ログイン", style: UIAlertAction.Style.default, handler: { (_: UIAlertAction!) in
            GIDSignIn.sharedInstance().signIn()
        })
        alert.addAction(signInAction)
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        if uid != nil {
            return signInSection.count
        } else {
            return signOutSection.count
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if uid != nil {
            return signInSection[section]
        } else {
            return signOutSection[section]
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        } else {
            return 20
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if uid != nil {
            switch section {
            case 0:
                return signInUserInfoTitle.count
            case 1:
                return signInConfigTitle.count
            case 2:
                return signInLogoutTitle.count
            default:
                return 0
            }
        } else {
            switch section {
            case 0:
                return signOutConfigTitle.count
            case 1:
                return signOutLoginIcon.count
            default:
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPageTableViewCell.self), for: indexPath) as! MyPageTableViewCell
        if uid != nil {
            switch indexPath.section {
            case 0:
                cell.textCellLabel.text = signInUserInfoTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named: signInUserInfoIcon[indexPath.row])
            case 1:
                cell.textCellLabel.text = signInConfigTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named: signInConfigIcon[indexPath.row])
            case 2:
                cell.textCellLabel.text = signInLogoutTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named: signOutLoginIcon[indexPath.row])
            default: break
            }
        } else {
            switch indexPath.section {
            case 0:
                cell.textCellLabel.text = signOutConfigTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named: signOutConfigIcon[indexPath.row])
            case 1:
                cell.textCellLabel.text = signOutLoginTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named: signOutLoginIcon[indexPath.row])
            default: break
            }
        }
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if uid != nil {
            switch indexPath.section {
            case 0:
                //ユーザー情報
                switch indexPath.row {
                case 0:
                    goMyPosts()
                    break
                case 1:
                    goMyFriends()
                    break
                case 2:
                    goMyFollows()
                    break
                case 3:

                    break
                default:
                    break
                }
                break
            case 1:
                switch indexPath.row {
                case 0:
                    //お問い合わせ
                    openWebView(navTitle: "お問い合わせ", url: CONTACT_PAGE_URL_STRING)
                    break
                case 1:
                    //アプリシェア
                    let alertView = SCLAlertView()
                    alertView.addButton("Twitter") {
                    }
                    alertView.showInfo("シェア", subTitle: "みんなの動物園を広める")

                    break
                case 2:
                    //利用規約
                    openWebView(navTitle: "利用規約", url: TOS_PAGE_URL_STRING)
                    break
                case 3:
                    //プライバシーポリシー
                    openWebView(navTitle: "プライバシーポリシー", url: PRIVACY_PAGE_URL)
                    break
                default:
                    break
                }
            case 2:
                //ログアウト
                self.myPageTableView.reloadData()
                SCLAlertView().showInfo("ログアウト", subTitle: "ログアウトが完了しました。")
                break
            default: break
            }
        } else {
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    //お問い合わせ
                    openWebView(navTitle: "お問い合わせ", url: CONTACT_PAGE_URL_STRING)
                    break
                case 1:
                    //アプリシェア
                    let alertView = SCLAlertView()
                    alertView.addButton("Twitter") {
                    }
                    alertView.showInfo("シェア", subTitle: "みんなの動物園を広める")

                    break
                case 2:
                    //利用規約
                    openWebView(navTitle: "利用規約", url: TOS_PAGE_URL_STRING)
                    break
                case 3:
                    //プライバシーポリシー
                    openWebView(navTitle: "プライバシーポリシー", url: PRIVACY_PAGE_URL)
                    break
                default:
                    break
                }
            case 1:
                //ログイン
                self.myPageTableView.reloadData()
                SCLAlertView().showInfo("ログアウト", subTitle: "ログアウトが完了しました。")
                break
            default: break
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
