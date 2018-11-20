import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import SCLAlertView

class UserInfoVC: CustumViewController, UITableViewDelegate, UITableViewDataSource {
    
    //テーブルビューインスタンス
    private var profileTableView: UITableView!
    
    //width, height
    private var profileCellHeight:CGFloat!
    private var postCellHeight:CGFloat!
    
    //UserInfo
    //ユーザーIDとユーザー名は受け取る
    var postUserID:Int!
    
    var userInfos:JSON = []
    var userName:String = ""
    var userProfile:String = ""
    var userIconUrl:String = ""
    var postsInfos:JSON = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        
        profileCellHeight = viewWidth*0.65
        postCellHeight = viewWidth*0.28
        
        setNavigationBar()
        setTableView()
        
        self.setIndicater()
        self.showIndicater()
        
        getUserInfo()
    }
    
    func getUserInfo() {
        //ユーザーの情報を取得する
        Alamofire.request(EveryZooAPI.getUserInfo(userID: postUserID)).responseJSON{ response in
            
            switch response.result {
            case .success:
            
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                if !json["userName"].stringValue.isEmpty {
                    self.userName = json["userName"].stringValue
                }
                if !json["profile"].stringValue.isEmpty {
                    self.userProfile = json["profile"].stringValue
                }
                if !json["iconUrl"].stringValue.isEmpty {
                    self.userIconUrl = json["iconUrl"].stringValue
                }
                
                self.getPosts()

            case .failure(let error):
                print(error)
                self.hideIndicator()
                SCLAlertView().showError("エラー", subTitle: "ユーザー情報の取得に失敗しました")
            }
        }
    }
    
    
    func getPosts() {
        //ユーザーの投稿を取得する
        Alamofire.request(EveryZooAPI.getUserPosts(userID: postUserID)).responseJSON{ response in
            
            switch response.result {
            case .success:
                let json:JSON = JSON(response.result.value ?? kill)
                if json["is_success"].boolValue {
                    self.postsInfos = json["response"]
                    self.profileTableView.reloadData()
                }else{
                    //不明なエラー
                    SCLAlertView().showError("エラー", subTitle: "不明なエラーです")
                }
                
            case .failure(let error):
                print(error)
                SCLAlertView().showError("エラー", subTitle: "ユーザー情報の取得に失敗しました")
            }
            self.hideIndicator()
        }
    }
    
    // MARK: ViewParts
    func setNavigationBar() {
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "プロフィール"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
    }
    
    func setTableView() {
        profileTableView = UITableView()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight-(statusBarHeight+tabBarHeight+navigationBarHeight))
        profileTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        profileTableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UserInfoTableViewCell.self))
        self.view.addSubview(profileTableView)
    }
    
    // MARK: TableViewDelegateMethods
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.postsInfos.count+1
    }
    
    //MARK: テーブルビューのセルの高さを計算する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return profileCellHeight
        }else {
            return postCellHeight
        }
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell:UserInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UserInfoTableViewCell.self), for: indexPath) as! UserInfoTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.backgroundColor = UIColor.MypageArrowGray()
            cell.iconImgView.sd_setImage(with: URL(string:self.userIconUrl), placeholderImage: UIImage(named: "icon_default"))
            cell.userNameLabel.text = self.userName
            cell.profileLabel.text = self.userProfile
            return cell
        }
        
        let cell:MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self), for: indexPath) as! MyPagePostCell
        if self.postsInfos.count == 0 {
            return cell
        }
        
        let dates = UtilityLibrary.parseDates(text: self.postsInfos[indexPath.row-1]["updated_at"].stringValue)
        var dateText:String = dates["year"]! + "/"
        dateText += dates["month"]! + "/" + dates["day"]!
        cell.dateLabel.text = dateText
        cell.titleLabel.text = self.postsInfos[indexPath.row-1]["title"].stringValue
        cell.commentLabel.text = self.postsInfos[indexPath.row-1]["caption"].stringValue
        let imageUrl = URL(string:self.postsInfos[indexPath.row-1]["image_url"].stringValue)!
        cell.thumbnailImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample_loading"))
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        
        if indexPath.row == 0 {
            return
        }
        
        //画面遷移、投稿詳細画面へ
        let picDetailView: PostDetailVC = PostDetailVC()
        //picDetailView.postID = self.postsInfos[indexPath.row-1]["id"].intValue
        let btn_back = UIBarButtonItem()
        btn_back.title = ""
        self.navigationItem.backBarButtonItem = btn_back
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
}
