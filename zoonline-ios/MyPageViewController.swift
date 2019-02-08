import UIKit
import Social
import FirebaseAuth
import GoogleSignIn
import SCLAlertView
import SDWebImage

class MyPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GIDSignInUIDelegate {

    var handle: AuthStateDidChangeListenerHandle!
    var isSignIn: Bool!

    // Sign In
    var signInSection: [String] = ["ユーザー情報", "設定・その他", "ログアウト"]
    var signInUserInfoTitle: [String] = ["投稿", "フレンズ", "フォロワー", "お気に入り"]
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

        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            print(auth)
            print(user)
        }

        if let user = Auth.auth().currentUser {
            // User is signed in.
            isSignIn = true
            userHeaderView.userNameLabel.text = user.displayName
            userHeaderView.userMailAdressLabel.text = user.email
        } else {
            // No user is signed in.
            isSignIn = false
            userHeaderView.userNameLabel.text = "未ログイン"
            userHeaderView.userMailAdressLabel.text = "ログインしてください"
            userHeaderView.iconImgView.image = UIImage(named: "common-icon-default")
        }
        myPageTableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    // MARK: - TableViewのデリゲートメソッド
    func numberOfSections(in tableView: UITableView) -> Int {
        return signOutSection.count
    }

    //セクションのタイトルを返す.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        //ログインしている場合はボタンをつける
        if UtilityLibrary.isLogin() {
            return signInSection[section]
        } else {
            return signOutSection[section]
        }
    }

    //セクションの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        } else {
            return 20
        }
    }

    //テーブルに表示する配列の総数を返す.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    }

    //Cellに値を設定する.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: MyPageTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPageTableViewCell.self), for: indexPath) as! MyPageTableViewCell
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

        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }

    //Cellが選択された際に呼び出される.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section {
        case 0:
            //ユーザー情報
            switch indexPath.row {
            case 0:
                //投稿一覧
                let vc: MyPostsViewController = MyPostsViewController()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
                break
            case 1:
                //フレンズ一覧
                let vc: FriendsListViewController = FriendsListViewController()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
                break
            case 2:
                //フォロワー一覧
                let vc: FollowerListViewController = FollowerListViewController()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
                break
            case 3:
                //お気に入り
                let vc: MyFavoritePostsViewController = MyFavoritePostsViewController()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
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
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            self.myPageTableView.reloadData()
            SCLAlertView().showInfo("ログアウト", subTitle: "ログアウトが完了しました。")
            break
        default: break

        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - アクションの設定

    //basicボタンが押されたら呼ばれます
    @objc internal func goMyProfile(sender: UIButton) {
        if isSignIn {
            let myProfilelViewController = MyProfilelViewController()
            myProfilelViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(myProfilelViewController, animated: true)
        } else {
            showConfirmAlert()
        }
    }

    func openWebView(navTitle: String, url: String) {
        //利用規約
        let contactView: WebViewController = WebViewController()
        contactView.url = url
        contactView.navTitle = navTitle
        contactView.view.backgroundColor = .white
        present(UINavigationController(rootViewController: contactView), animated: true, completion: nil)
    }

    func showConfirmAlert() {
        let actionAlert = UIAlertController(title: "", message: "Googleログインが必要です", preferredStyle: UIAlertController.Style.alert)

        // set login alert
        let kabigonAction = UIAlertAction(title: "ログイン", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
            GIDSignIn.sharedInstance().signIn()
        })
        actionAlert.addAction(kabigonAction)

        // set cancel alert
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        actionAlert.addAction(cancelAction)

        // show alert
        present(actionAlert, animated: true, completion: nil)
    }
}
