import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import SCLAlertView

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //テーブルビューインスタンス
    private var profileTableView: UITableView!

    //width, height
    private var profileCellHeight: CGFloat!
    private var postCellHeight: CGFloat!

    //UserInfo
    //ユーザーIDとユーザー名は受け取る
    var postUserID: Int!

    var userInfos: JSON = []
    var userName: String = ""
    var userProfile: String = ""
    var userIconUrl: String = ""
    var postsInfos: JSON = []

    private var myItems: Array<String> = ["天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
    "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
    "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
    "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
    "天王寺動物園"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        // ユーザー情報
        let userInfoView = UserInfoView()
        userInfoView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 260)

        profileTableView = UITableView()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.tableHeaderView = userInfoView
        profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        view.addSubview(profileTableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.frame.width
        let height = view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)
        profileTableView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }

    // MARK: ViewParts
    func setNavigationBar() {
        let titleLabel: NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "プロフィール"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
    }

    // MARK: TableView Delegate Methods
    // テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return 20
    }

    // テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self))!
        cell.textLabel?.text = "aaaaaaaaa"
        return cell
    }

    // テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
}
