import UIKit
import Social
import Alamofire
import SwiftyJSON
import SCLAlertView
import SDWebImage

class PostDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var postDetailTableView: UITableView!

    private var myItems: [String] = []

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
        let postDetailView = PostDetailView()
        postDetailView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: postDetailView.calcHeight(viewWidth: view.frame.width))

        // ボタンアクションの設定
        postDetailView.userInfoButton.addTarget(self, action: #selector(userInfoButtonTouched(sender:)), for: .touchUpInside)
        postDetailView.commentButton.addTarget(self, action: #selector(commentButtonTouched(sender:)), for: .touchUpInside)
        postDetailView.followButton.addTarget(self, action: #selector(followButtonTouched(sender:)), for: .touchUpInside)

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
        // tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.frame.width
        let height = view.frame.height
        // let height = view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)
        postDetailTableView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }

    // MARK: Button Actions
    @objc func userInfoButtonTouched(sender: UIButton) {
        // ユーザー詳細画面へ
        let userInfoViewController = UserInfoViewController(uid: "sdfsdf")
        self.navigationController?.pushViewController(userInfoViewController, animated: true)
    }

    @objc func commentButtonTouched(sender: UIButton) {
        // コメント投稿へ
        let  postCommentViewController = PostCommentViewController()
        self.navigationController?.pushViewController(postCommentViewController, animated: true)
    }

    @objc func followButtonTouched(sender: UIButton) {
        print("basicButtonBtnClicked")
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
    
    
    func setTableView() {
        
        //テーブルビューの初期化
        postDetailTableView = UITableView()
        postDetailTableView.delegate = self
        postDetailTableView.dataSource = self
        
        //テーブルビューの大きさの指定
        postDetailTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        
        //テーブルビューの設置
        postDetailTableView.register(PostDetailTableCell.self, forCellReuseIdentifier: NSStringFromClass(PostDetailTableCell.self))
        UITableView.appearance().layoutMargins = UIEdgeInsets.zero
        UITableViewCell.appearance().layoutMargins = UIEdgeInsets.zero
        self.view.addSubview(postDetailTableView)
    }
    
    func setActivityIndicator(){
        indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: viewWidth*0.35, y: viewHeight*0.4-44, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        self.view.bringSubviewToFront(indicator)
        indicator.color = UIColor.init(named: "main")
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func setSupportBtn() {
        //サポート
        supportBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: self.tableViewHeight)
        supportBtn.setImage(UIImage(named:"support_detail"), for: UIControl.State.normal)
        supportBtn.imageView?.contentMode = UIView.ContentMode.bottomRight
        supportBtn.contentHorizontalAlignment = .fill
        supportBtn.contentVerticalAlignment = .fill
        supportBtn.backgroundColor = UIColor.clear
        supportBtn.addTarget(self, action: #selector(supportBtnClicked(sender:)), for:.touchUpInside)
        self.view.addSubview(supportBtn)
    }
    
    @objc func supportBtnClicked(sender: UIButton){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(true, forKey: "KEY_SUPPORT_PostDetail")
        supportBtn.removeFromSuperview()
    }
    
    func calcTableViewHeight() {
        userInfoBtnHeight = viewWidth*0.16
        postImgHeight = viewWidth
        
        if postImgAspect > 1 {
            postImgHeight = viewWidth
        }else {
            postImgHeight = viewWidth * postImgAspect
        }
        
        favComentMenuBtnHeight = viewWidth * 0.15
        dateLabelHeigt = viewWidth * 0.05
    }

     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:PostDetailTableCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostDetailTableCell.self), for: indexPath) as! PostDetailTableCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        //UserInfoBtn
        let userInfoBtnWidth:CGFloat = viewWidth*0.65
        cell.userInfoBtn.frame = CGRect(x: 0, y: 0, width: userInfoBtnWidth, height: userInfoBtnHeight)
        cell.userInfoBtn.addTarget(self, action: #selector(userInfoBtnClicked(sender:)), for:.touchUpInside)
        cell.thumbnailImgView.frame = CGRect(x: userInfoBtnHeight*0.2, y: userInfoBtnHeight*0.15, width: userInfoBtnHeight*0.7, height: userInfoBtnHeight*0.7)
        cell.thumbnailImgView.layer.cornerRadius = cell.thumbnailImgView.frame.height * 0.5
        if let url = URL(string:self.iconUrl) {
            cell.thumbnailImgView.sd_setImage(with: url, placeholderImage:  UIImage(named:"icon_default")!)
        }
        cell.userNameTextView.frame = CGRect(x: userInfoBtnHeight, y: 0, width: userInfoBtnWidth-userInfoBtnHeight, height: userInfoBtnHeight)
        cell.userNameTextView.text = postUserName

        //FollowBtn
        let followBtnWidth:CGFloat = viewWidth - userInfoBtnWidth
        let followBtnHeight:CGFloat = userInfoBtnHeight
        cell.followBtn.frame = CGRect(x: userInfoBtnWidth, y: 0, width: followBtnWidth, height: followBtnHeight)
        cell.followBtn.addTarget(self, action: #selector(followBtnClicked(sender:)), for:.touchUpInside)
        
        // FIXME: 良い感じに修正する
        if Int(UtilityLibrary.getUserID()) == Int(postUserID) {
            cell.followBtn.removeFromSuperview()
        }
        
        if isFriends! {
            cell.followBtn.followImgView.image = UIImage(named: "follow_icon_on")!
            cell.followBtn.followLabel.text = "フレンズ"
        }
        
        //PostImgView
        cell.postImgView.frame = CGRect(x: 0, y: userInfoBtnHeight, width: viewWidth, height: postImgHeight)
        if let imageUrl = URL(string: self.postImgUrl){
            cell.postImgView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample_loading"))
        }
        //画像にタッチイベントを追加
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(sender:)))
        singleTap.numberOfTapsRequired = 1
        cell.postImgView.addGestureRecognizer(singleTap)
        
        
        //FavBtn
        //let favComentMenuBtnHeight:CGFloat = viewWidth*0.15
        let favBtnSpace:CGFloat = viewWidth*0.05
        let favBtnWidth:CGFloat = viewWidth*0.25
        cell.favBtn.frame = CGRect(x: favBtnSpace, y: userInfoBtnHeight+postImgHeight, width: favBtnWidth, height: favComentMenuBtnHeight)
        cell.favBtn.countLabel.text = String(self.favList.count)
        cell.favBtn.addTarget(self, action: #selector(favBtnClicked(sender:)), for:.touchUpInside)
        //お気に入りの投稿の中に含まれている場合は色を変える
        for id in favList{

            if String(describing: id) == myUserID {
                cell.favBtn.imgView.image = UIImage(named: "fav_on")!
                break
            }
        }
        
        //CommentBtn
        let commentBtn:CGFloat = favBtnWidth
        cell.commentBtn.frame = CGRect(x: favBtnSpace+favBtnWidth, y: userInfoBtnHeight+postImgHeight, width: commentBtn, height: favComentMenuBtnHeight)
        cell.commentBtn.countLabel.text = String(self.commentList.count)
        cell.commentBtn.addTarget(self, action: #selector(commentBtnClicked(sender:)), for:.touchUpInside)
        
        //MenuBtn
        let menuBtnWidth:CGFloat = favComentMenuBtnHeight
        cell.menuBtn.frame = CGRect(x: viewWidth-menuBtnWidth*1.1, y: userInfoBtnHeight+postImgHeight, width: menuBtnWidth, height: favComentMenuBtnHeight)
        cell.menuBtn.addTarget(self, action: #selector(showActionShert(sender:)), for:.touchUpInside)

        //DateLabel
        //let dateLabelHeigt:CGFloat = viewHeight*0.05
        var dateLabelYPos:CGFloat = userInfoBtnHeight+postImgHeight
        dateLabelYPos += favComentMenuBtnHeight
        cell.dateLabel.frame = CGRect(x: viewWidth*0.05, y: dateLabelYPos, width: viewWidth*0.9, height: dateLabelHeigt)
        cell.dateLabel.text = pubDate
        
        //DescriptionLabel
        let descriptionTextViewWidth:CGFloat = viewWidth*0.92
        var descriptionTextViewYPos:CGFloat = userInfoBtnHeight+postImgHeight
        descriptionTextViewYPos += favComentMenuBtnHeight
        descriptionTextViewYPos += dateLabelHeigt
        cell.descriptionTextView.frame = CGRect(x: viewWidth*0.04, y: descriptionTextViewYPos, width: descriptionTextViewWidth, height: 5)
        cell.descriptionTextView.text = self.postCaption
        cell.descriptionTextView.sizeToFit()
        
        return cell
    }
    
    //高さの設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        //ユーザーの高さ、viewWidth*0.16
        //投稿画像の高さ、可変
        //コメントボタンなどの高さ、viewWidth * 0.15
        //日時のラベルの高さ、viewHeight*0.05
        //解説の高さ、可変
        //お尻に余白、viewHeight*0.05
        
        var cellHeight:CGFloat = userInfoBtnHeight+postImgHeight
        cellHeight += favComentMenuBtnHeight
        cellHeight += dateLabelHeigt
        //高さを計算
        cellHeight += UtilityLibrary.calcTextViewHeight(text: self.postCaption, width: viewWidth*0.92, font: UIFont.systemFont(ofSize: 16))
        
        return cellHeight
    }
    

    @objc func tapSingle(sender: UITapGestureRecognizer) {
        print(sender.view?.tag ?? 400)
        
        if let img = sender.view as? UIImageView{
            //画像拡大
            let picExpandVC:PictureExpandVC = PictureExpandVC()
            picExpandVC.statusBarHeight = self.statusBarHeight
            picExpandVC.navigationBarHeight = self.navigationBarHeight
            picExpandVC.image = img.image
            picExpandVC.navigationTitle = self.postTitle
            picExpandVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(picExpandVC, animated: true, completion: nil)
        }else{
            //エラー
        
        }
    }
    
    //フォローボタンが押されたら呼ばれる
    @objc func followBtnClicked(sender: FollowUserButton){
        
    }
    
    //ファボボタンが押されたら呼ばれる
    @objc func favBtnClicked(sender: FavCommentButton){
        
        if !(UtilityLibrary.isLogin()) {
            //ログインしていない
            SCLAlertView().showInfo("ログインが必要です", subTitle: "お気に入り機能を使うにはログインが必要だよ！")
            return
        }
        
        let postFavorite:String = EveryZooAPI.getDoFavoritePost(userID: Int(myUserID)!, postID: postID)
        if sender.imgView.image == UIImage(named:"fav_on") {
            sender.imgView.image = UIImage(named: "fav_off")!
            sender.countLabel.textColor = UIColor.TextColorGray()
            let favCount:String = sender.countLabel.text!
            sender.countLabel.text = String(Int(favCount)!-1)

            Alamofire.request(postFavorite, method: .delete, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON{ response in
                
                switch response.result {
                case .success:
                    
                    let json:JSON = JSON(response.result.value ?? kill)
                    print(json)
                    
                case .failure(let error):
                    print(error)
                }
            }

        }else{
            sender.imgView.image = UIImage(named: "fav_on")!
            sender.countLabel.textColor = UIColor.PostDetailFavPink()
            let favCount:String = sender.countLabel.text!
            sender.countLabel.text = String(Int(favCount)!+1)
            
            Alamofire.request(postFavorite, method: .post, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON{ response in
                
                switch response.result {
                case .success:
                    
                    let json:JSON = JSON(response.result.value ?? kill)
                    print(json)
                    
                case .failure(let error):
                    print(error)
                    //テーブルの再読み込み
                }
            }
        }
    }

    
    //コメントボタンが押されたら呼ばれる
    @objc func commentBtnClicked(sender: FavCommentButton){
        
        goCommentView()
    }
    
    //ユーザー情報が押されたら呼ばれる
    @objc func userInfoBtnClicked(sender: UIButton){
        
        //画面遷移、ユーザー情報画面へ
        let userInfoView: UserInfoViewController = UserInfoViewController()
        userInfoView.postUserID = self.postUserID
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(userInfoView, animated: true)
    }
    
    @objc func showActionShert(sender: UIButton){
        
        // インスタンス生成　styleはActionSheet.
        let actionAlert = UIAlertController(title: "メニュー", message: "操作を選んでください", preferredStyle: UIAlertController.Style.actionSheet)
        
        if UtilityLibrary.isLogin() {
            
            // アクションを生成.
            let commentAction = UIAlertAction(title: "コメント", style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) in
                // コメント画面へ遷移
                self.goCommentView()
            })
            actionAlert.addAction(commentAction)
            
            if postUserID == Int(UtilityLibrary.getUserID()) {
                
                let addAlbumAction = UIAlertAction(title: "投稿を削除", style: UIAlertAction.Style.default, handler: {
                    (action: UIAlertAction!) in
                    
                    let alertView = SCLAlertView()
                    alertView.addButton("削除") {
                        self.deletePost()
                    }
                    alertView.showInfo("投稿削除", subTitle: "投稿を削除しますか？")
                    
                })
                actionAlert.addAction(addAlbumAction)
            }
        }

        
        let reportAction = UIAlertAction(title: "レポート", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            
            //お問い合わせ
            let contactView:WebViewController = WebViewController()
            contactView.statusBarHeight = self.statusBarHeight
            contactView.navigationBarHeight = self.navigationBarHeight
            contactView.url = CONTACT_PAGE_URL_STRING
            contactView.navTitle = "お問い合わせ"
            self.present(contactView, animated: true, completion: nil)
        })
        actionAlert.addAction(reportAction)

        
        let shareAction = UIAlertAction(title: "シェアする", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            let alertView = SCLAlertView()
            alertView.addButton("Twitter") {
                self.tweet()
            }
            alertView.showInfo("シェア", subTitle: "投稿を広める")
            
        })
        actionAlert.addAction(shareAction)

        
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセルをタップした時の処理")
        })
        // アクションを追加.
        actionAlert.addAction(cancelAction)
        
        self.present(actionAlert, animated: true, completion: nil)
    }
  

     func goCommentView(){
        // 移動先のViewを定義する.
        let commentListlView: CommentListViewController = CommentListViewController()
        commentListlView.postsID = postID
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(commentListlView, animated: true)
    }
    

    func getPostInfo(postID:Int){
        
        Alamofire.request(EveryZooAPI.getPostsInfo(postID: postID)).responseJSON{
            response in
            
            switch response.result {
            case .success:
                let json:JSON = JSON(response.result.value ?? kill)
                
                if !json["is_success"].boolValue{
                    SCLAlertView().showInfo("エラー", subTitle: "投稿情報の取得に失敗しました。")
                    _ = self.navigationController?.popViewController(animated: true)
                }
                
                self.postUserName = json["responce"]["userName"].stringValue
                self.postUserID = json["responce"]["userId"].intValue
                self.postTitle = json["responce"]["title"].stringValue
                self.postCaption = json["responce"]["caption"].stringValue
                self.postImgUrl = json["responce"]["imageInfo"]["image_url"].stringValue
                self.iconUrl = json["responce"]["iconUrl"].stringValue
                
                print(json)
                let dateDic = UtilityLibrary.parseDates(text: json["responce"]["updated_at"].stringValue)
                var pubDate = dateDic["year"]! + "年" + dateDic["month"]!  + "月"
                pubDate += dateDic["day"]! + "日"
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
                
                let json:JSON = JSON(response.result.value ?? kill)
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
            let didSupport:Bool = (appDelegate.userDefaultsManager?.userDefaults.bool(forKey: "KEY_SUPPORT_PostDetail"))!
            if !didSupport {
                
                self.setSupportBtn()
            }
            return
        }
        
        let userID = Int(UtilityLibrary.getUserID())
        Alamofire.request(EveryZooAPI.getFriends(userID: userID!)).responseJSON{ response in
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                
                if json["is_success"].boolValue {
                    
                    self.isFriends = self.checkIsFriends(friendsList: json["responce"])
                    
                    self.calcTableViewHeight()
                    self.setNavigationBar()
                    self.setTableView()
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let didSupport:Bool = (appDelegate.userDefaultsManager?.userDefaults.bool(forKey: "KEY_SUPPORT_PostDetail"))!
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
    
    func checkIsFriends(friendsList:JSON) -> Bool {
        
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
