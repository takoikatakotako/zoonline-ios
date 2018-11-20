import UIKit
import Social
import SCLAlertView
import SDWebImage

class MyPageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //ユーザー数の
    var userCellBtn:MyPageUserCellBtn!
    
    //テーブルビューインスタンス
    private var myPageTableView: UITableView!

    var myComposeView : SLComposeViewController!
    
    //
    var loginedSectionTitle:[String] = ["ユーザー情報", "設定・その他", "ログアウト"]
    var unloginedSectionTitle:[String] = ["設定・その他", "ログイン"]
    
    var userInfoTitle:[String] = ["投稿","フレンズ","フォロワー","お気に入り"]
    var userInfoIcon:[String] = ["mypage_post","mypage_friends","mypage_follower","mypage_favorite"]
    
    var configsTitle:[String] = ["お問い合わせ", "シェア", "利用規約", "プライバシーポリシー"]
    var configsIcon:[String] = ["mypage_contact","mypage_share","mypage_info","mypage_caution"]
    
    var logoutTitle:[String] = ["ログアウト"]
    var logoutIcon:[String] = ["mypage_logout"]
    var loginTitle:[String] = ["ログイン"]
    var loginIcon:[String] = ["mypage_logout"]

    
    // Sectionで使用する配列を定義する.
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.MypageArrowGray()
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel(frame: CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: 40))
        titleLabel.text = "マイページ"
        self.navigationItem.titleView = titleLabel
        
        // header
        userCellBtn = MyPageUserCellBtn(frame:CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        userCellBtn.backgroundColor = UIColor.white
        userCellBtn.addTarget(self, action: #selector(MyPageVC.goMyProfile(sender:)), for:.touchUpInside)
        let defaultIcon = UIImage(named:"common-icon-default")
        if let url = URL(string: UtilityLibrary.getUserIconUrl()){
            userCellBtn.iconImgView.sd_setImage(with: url, placeholderImage: defaultIcon)
        }else{
            userCellBtn.iconImgView.image = defaultIcon
        }

        // table
        myPageTableView = UITableView(frame: view.frame,style: UITableView.Style.grouped)
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
        myPageTableView.backgroundColor = UIColor.MypageArrowGray()
        myPageTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MyPageTableViewCell.self))
        myPageTableView.rowHeight = 48
        myPageTableView.tableHeaderView = userCellBtn
        view.addSubview(myPageTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //user用のセル
        if (UtilityLibrary.isLogin()) {
            //ログイン
            userCellBtn.userNameLabel.text = UtilityLibrary.getUserName()
            userCellBtn.userMailAdressLabel.text = UtilityLibrary.getUserEmail()
        }else{
            //未ログイン
            userCellBtn.userNameLabel.text = "未ログイン"
            userCellBtn.userMailAdressLabel.text = "ログインしてください"
            userCellBtn.iconImgView.image = UIImage(named:"icon_default")
        }
        
        myPageTableView.reloadData()
    }

    // MARK: - TableViewのデリゲートメソッド
    
    //セクションの数を返す.
    func numberOfSections(in tableView: UITableView) -> Int {
            return unloginedSectionTitle.count
    }
    
    //セクションのタイトルを返す.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //ログインしている場合はボタンをつける
        if UtilityLibrary.isLogin() {
            return loginedSectionTitle[section]
        }else{
            return unloginedSectionTitle[section]
        }
    }
    
    
    //セクションの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }else{
            return 20
        }
    }
    
    //テーブルに表示する配列の総数を返す.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            switch section {
            case 0:
                return userInfoTitle.count
            case 1:
                return configsTitle.count
            case 2:
                return logoutTitle.count
            default:
                return 0
            }

    }
    
    //Cellに値を設定する.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyPageTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPageTableViewCell.self), for: indexPath) as! MyPageTableViewCell
            switch indexPath.section {
            case 0:
                cell.textCellLabel.text =  userInfoTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named:userInfoIcon[indexPath.row])
            case 1:
                cell.textCellLabel.text =  configsTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named:configsIcon[indexPath.row])
            case 2:
                cell.textCellLabel.text =  logoutTitle[indexPath.row]
                cell.thumbnailImgView.image = UIImage(named:loginIcon[indexPath.row])
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
                    let vc:MyPagePostViewController = MyPagePostViewController()
                    vc.userID = Int(UtilityLibrary.getUserID())
                    
                    let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    self.navigationItem.backBarButtonItem = backButton
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 1:
                    //フレンズ一覧
                    let vc:FriendsListViewController = FriendsListViewController()
                    vc.userID = Int(UtilityLibrary.getUserID())
                    
                    let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    self.navigationItem.backBarButtonItem = backButton
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 2:
                    //フォロワー一覧
                    let vc:FollowerListViewController = FollowerListViewController()
                    vc.userID = Int(UtilityLibrary.getUserID())
                    
                    let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    self.navigationItem.backBarButtonItem = backButton
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 3:
                    //お気に入り
                    let vc:MyPageFavoriteViewController = MyPageFavoriteViewController()
                    vc.userID = Int(UtilityLibrary.getUserID())
                    
                    let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    self.navigationItem.backBarButtonItem = backButton
                    self.navigationController?.pushViewController(vc, animated: true)
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
                        self.tweet()
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
                appDelegate.userDefaultsManager?.doLogout()
                self.myPageTableView.reloadData()
                SCLAlertView().showInfo("ログアウト", subTitle: "ログアウトが完了しました。")
                break
            default: break
                
            }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - アクションの設定
    
    //basicボタンが押されたら呼ばれます
    @objc internal func goMyProfile(sender: UIButton){
        
        if !(UtilityLibrary.isLogin()){

            let loginView:LoginViewController = LoginViewController()
            //loginView.statusBarHeight = self.statusBarHeight
            //loginView.navigationBarHeight = self.navigationBarHeight
            self.present(loginView, animated: true, completion: nil)
            return
        }
        
        let vc:MyPageProfilelViewController = MyPageProfilelViewController()
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openWebView(navTitle:String, url:String){
    
        //利用規約
        let contactView:WebViewController = WebViewController()
        //contactView.statusBarHeight = self.statusBarHeight
        //contactView.navigationBarHeight = self.navigationBarHeight
        contactView.url = url
        contactView.navTitle = navTitle
        self.present(contactView, animated: true, completion: nil)
    }
    
    func tweet() {
        /*
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        myComposeView.setInitialText("#みんなの動物園")
        self.present(myComposeView, animated: true, completion: nil)
 */
    }
}
