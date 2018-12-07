import UIKit
import Social
import Alamofire
import SwiftyJSON
import SCLAlertView
import SDWebImage

class PostDetailVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    private var postDetailTableView: UITableView!

    private var myItems: Array<String> = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        myItems = ["天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
                   "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
                   "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
                   "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ",
                   "天王寺動物園"]

        // 投稿
        let postDetailView = PostDetailView()
        postDetailView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: postDetailView.calcHeight(viewWidth: view.frame.width))
        
        //テーブルビューの初期化
        postDetailTableView = UITableView()
        postDetailTableView.delegate = self
        postDetailTableView.dataSource = self
        postDetailTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(CommentTableViewCell.self))
        postDetailTableView.tableHeaderView = postDetailView
        postDetailTableView.rowHeight = 100
        view.addSubview(postDetailTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.frame.width
        let height = view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)
        //テーブルビューの大きさの指定
        postDetailTableView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }

    
    // MARK: TableView Delegate Methods
    // テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return myItems.count
    }
    
    // テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CommentTableViewCell.self))! as! CommentTableViewCell
        cell.commentTextView.text = myItems[indexPath.row]
        return cell
    }
    
    // テーブルビューの高さを指定する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommentTableViewCell.calcHeight(viewWidth: view.frame.width, comments: myItems[indexPath.row])
    }
    
    // テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
    
    
    
    /*
    //Post ID
    public var postID:Int!
    private var myUserID:String!
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    var tableViewHeight:CGFloat!
    

    //TableViewsHeights
    private var userInfoBtnHeight:CGFloat!
    private var postImgHeight:CGFloat!
    private var favComentMenuBtnHeight:CGFloat!
    private var dateLabelHeigt:CGFloat!
    
    //Post Datas
    var postUserID:Int!
    var postUserName:String = ""
    var iconUrl:String = ""
    var postTitle:String = ""
    var postCaption:String = ""
    var commentList:Array<Any>!
    var favList:Array<Any>!
    var postImgUrl:String!
    var postImgAspect:CGFloat!
    var pubDate:String!
    var isFriends:Bool!
    var indicator: UIActivityIndicatorView!
    
    //view parts
    private var postDetailTableView: UITableView!
    
    //サポートボタン
    let supportBtn:UIButton = UIButton()
    
    var myComposeView : SLComposeViewController!
    */
        /*
        
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        tableViewHeight = viewHeight-(statusBarHeight+navigationBarHeight+tabBarHeight)
        
        //
        setNavigationBar()
        setActivityIndicator()
        indicator.startAnimating()
        
        myUserID = UtilityLibrary.getUserID()
        
        //投稿の情報の取得
        getPostInfo(postID: self.postID)
 

    }
 */
    // MARK: pubDate += dateDic["day"]! + "日"
                pubDate += dateDic["hour"]!  + "時" + dateDic["minute"]!  + "分"
                self.pubDate = pubDate

                self.commentList = json["responce"]["commentList"].arrayValue
                self.favList = json["responce"]["favList"].arrayValue

                //postImageAspecg
                let height = json["responce"]["imageInfo"]["height"].floatValue
                let width = json["responce"]["imageInfo"]["width"].floatValue
                if width != 0.0 {
                    self.postImgAspect = CGFloat(height/width)
                }else{
                    self.postImgUrl = json["responce"]["itemImage"].stringValue
                    self.postImgAspect = 1
                }
                
                self.getFriends()
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func deletePost() {
        
        
        let url = EveryZooAPI.getPostsInfo(postID: postID)
        Alamofire.request(url, method: .delete, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json: JSON = JSON(response.result.value ?? kill)
                if json["is_success"].boolValue {
                    SCLAlertView().showInfo("投稿の削除", subTitle: "投稿を削除しました。")
                    _ = self.navigationController?.popViewController(animated: true)
                }else{
                
                    SCLAlertView().showError("投稿の削除", subTitle: "投稿の削除に失敗しました。") // Erro
                }
                
                print(json)
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
        
    }
    
    func getFriends() {
        
        //ログインしていないときはすぐ返す
        if !UtilityLibrary.isLogin() {
            self.isFriends = false
            self.calcTableViewHeight()
            self.setNavigationBar()
            self.setTableView()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let didSupport: Bool = (appDelegate.userDefaultsManager?.userDefaults.bool(forKey: "KEY_SUPPORT_PostDetail"))!
            if !didSupport {
                
                self.setSupportBtn()
            }
            return
        }
        
        let userID = Int(UtilityLibrary.getUserID())
        Alamofire.request(EveryZooAPI.getFriends(userID: userID!)).responseJSON{ response in
            switch response.result {
            case .success:
                
                let json: JSON = JSON(response.result.value ?? kill)
                print(json)
                
                if json["is_success"].boolValue {
                    
                    self.isFriends = self.checkIsFriends(friendsList: json["responce"])
                    
                    self.calcTableViewHeight()
                    self.setNavigationBar()
                    self.setTableView()
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let didSupport: Bool = (appDelegate.userDefaultsManager?.userDefaults.bool(forKey: "KEY_SUPPORT_PostDetail"))!
                    if !didSupport {
                        
                        self.setSupportBtn()
                    }
                
                }else{
                    //エラー
                    SCLAlertView().showInfo("エラー", subTitle: "ネットワーク接続に失敗しました")
                }
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }
    
    func checkIsFriends(friendsList: JSON) -> Bool {
        
        for i in 0..<friendsList.count {
            if friendsList[i]["user-id"].intValue == postUserID { return true }
        }
        return false
    }
    
    
    func tweet() {
        /*
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        myComposeView.setInitialText("#みんなの動物園")
        self.present(myComposeView, animated: true, completion: nil)
         */
    }
 
 */
}
