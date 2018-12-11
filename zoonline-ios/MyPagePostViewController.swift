import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import SCLAlertView

class MyPagePostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userID: Int!

    //width, height
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    private var statusBarHeight: CGFloat!
    private var navigationBarHeight: CGFloat!
    private var tabBarHeight: CGFloat!
    private var tableViewHeight: CGFloat!

    //テーブルビューインスタンス
    private var postListTableView: UITableView!
    private var postsContents: JSON = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+tabBarHeight)

        self.view.backgroundColor = UIColor.white

        setNavigationBar()

        postListTableView = UITableView()
        postListTableView.delegate = self
        postListTableView.dataSource = self
        postListTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        postListTableView.rowHeight = viewWidth*0.28

        //テーブルビューの設置
        postListTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        self.view.addSubview(postListTableView)

        //
        getMyPosts()
    }

    func getMyPosts() {

        Alamofire.request(EveryZooAPI.getUserPosts(userID: userID)).responseJSON { response in

            switch response.result {
            case .success:

                let json: JSON = JSON(response.result.value ?? kill)

                if json["is_success"].boolValue {
                    print(json)
                    self.postsContents = json["response"]
                    self.postListTableView.reloadData()
                }else {
                    SCLAlertView().showInfo("エラー", subTitle: "不明なエラーです")
                }

            case .failure(let error):
                print(error)
                SCLAlertView().showInfo("エラー", subTitle: "インターネットの接続を確認してください")
            }
        }
    }

    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {

        self.navigationController?.navigationBar.barTintColor = UIColor.init(named: "main")
        self.navigationController?.navigationBar.isTranslucent = false

        //ナビゲーションアイテムを作成
        let titleLabel: NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "投稿一覧"
        titleLabel.textColor = UIColor.white

        self.navigationItem.titleView = titleLabel
    }

    // MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return postsContents.count
    }

    // MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell: MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self))! as! MyPagePostCell

        print("----------")
        print(self.postsContents[indexPath.row])

        let dates = UtilityLibrary.parseDates(text: self.postsContents[indexPath.row]["created_at"].stringValue)
        var dateText: String = dates["year"]! + "/"
        dateText += dates["month"]! + "/"
        dateText += dates["day"]!
        cell.dateLabel.text = dateText
        cell.titleLabel.text = self.postsContents[indexPath.row]["title"].stringValue
        cell.commentLabel.text = self.postsContents[indexPath.row]["caption"].stringValue
        let imageUrl = URL(string: self.postsContents[indexPath.row]["image_url"].stringValue)!
        cell.thumbnailImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample_loading"))

        return cell
    }

    // MARK: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        //画面遷移、投稿詳細画面へ
        let picDetailView: PostDetailViewController = PostDetailViewController()
        //picDetailView.postID = self.postsContents[indexPath.row]["id"].intValue
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
}
