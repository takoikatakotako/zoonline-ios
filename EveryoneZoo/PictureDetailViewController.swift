//
//  PictureDetailViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Social
import Alamofire
import AlamofireImage
import SwiftyJSON
import SCLAlertView

class PictureDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

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
    
    // MARK: - Viewにパーツの設置
    // MARK: NavigationBar
    func setNavigationBar() {
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = self.postTitle
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }
    
    // MARK: TableView
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
    
    // MARK: くるくるの生成
    func setActivityIndicator(){
        indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: viewWidth*0.35, y: viewHeight*0.4-44, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.view.bringSubview(toFront: indicator)
        indicator.color = UIColor.MainAppColor()
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func setSupportBtn() {
        //サポート
        supportBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: self.tableViewHeight)
        supportBtn.setImage(UIImage(named:"support_sample"), for: UIControlState.normal)
        supportBtn.imageView?.contentMode = .scaleAspectFit
        supportBtn.contentHorizontalAlignment = .fill
        supportBtn.contentVerticalAlignment = .fill
        supportBtn.backgroundColor = UIColor.clear
        supportBtn.addTarget(self, action: #selector(supportBtnClicked(sender:)), for:.touchUpInside)
        self.view.addSubview(supportBtn)
    }
    
    //MARK: ButtonActions
    func supportBtnClicked(sender: UIButton){
        
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
    
    // MARK: - TableView Delegate Method
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:PostDetailTableCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostDetailTableCell.self), for: indexPath) as! PostDetailTableCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        //UserInfoBtn
        let userInfoBtnWidth:CGFloat = viewWidth*0.65
        cell.userInfoBtn.frame = CGRect(x: 0, y: 0, width: userInfoBtnWidth, height: userInfoBtnHeight)
        cell.userInfoBtn.addTarget(self, action: #selector(userInfoBtnClicked(sender:)), for:.touchUpInside)
        cell.thumbnailImgView.frame = CGRect(x: userInfoBtnHeight*0.2, y: userInfoBtnHeight*0.15, width: userInfoBtnHeight*0.7, height: userInfoBtnHeight*0.7)
        cell.thumbnailImgView.layer.cornerRadius = cell.thumbnailImgView.frame.height * 0.5
        if let url = URL(string:self.iconUrl) {
            cell.thumbnailImgView.af_setImage(withURL: url, placeholderImage:  UIImage(named:"icon_default")!)
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
        //let postImgHeight:CGFloat = viewWidth*2
        cell.postImgView.frame = CGRect(x: 0, y: userInfoBtnHeight, width: viewWidth, height: postImgHeight)
        if let imageUrl = URL(string: self.postImgUrl){
            cell.postImgView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample_loading"))
        }
        
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
    
    //Mark: - Actions
    //フォローボタンが押されたら呼ばれる
    func followBtnClicked(sender: FollowUserButton){
        
        if !(UtilityLibrary.isLogin()){
            SCLAlertView().showInfo("ログインしてね", subTitle: "フォロー機能を使うにはログインが必要だよ！")
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if sender.followImgView.image == UIImage(named:"follow_icon") {
            sender.followImgView.image = UIImage(named: "follow_icon_on")!
            appDelegate.networkManager?.followUser(myUserId: Int(UtilityLibrary.getUserID())!, followUserId: postUserID)
            sender.followLabel.text = "フレンズ"
            
        }else{
            sender.followImgView.image = UIImage(named: "follow_icon")!
            appDelegate.networkManager?.unfollowUser(myUserId: Int(UtilityLibrary.getUserID())!, followUserId: postUserID)
            sender.followLabel.text = "フォロー"
        }
    }
    
    //ファボボタンが押されたら呼ばれる
    func favBtnClicked(sender: FavCommentButton){
        
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
    func commentBtnClicked(sender: FavCommentButton){
        
        goCommentView()
    }
    
    //ユーザー情報が押されたら呼ばれる
    func userInfoBtnClicked(sender: UIButton){
        
        //画面遷移、ユーザー情報画面へ
        let userInfoView: UserInfoViewController = UserInfoViewController()
        userInfoView.postUserID = self.postUserID
        
        let btn_back = UIBarButtonItem()
        btn_back.title = ""
        self.navigationItem.backBarButtonItem = btn_back
        self.navigationController?.pushViewController(userInfoView, animated: true)
    }
    
    //Mark: コメント投稿画面への遷移
    func showActionShert(sender: UIButton){
        
        // インスタンス生成　styleはActionSheet.
        let actionAlert = UIAlertController(title: "操作メニュー", message: "操作を選んでください。", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if UtilityLibrary.isLogin() {
            
            // アクションを生成.
            let commentAction = UIAlertAction(title: "コメント", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) in
                // コメント画面へ遷移
                self.goCommentView()
            })
            actionAlert.addAction(commentAction)
            
            let addAlbumAction = UIAlertAction(title: "お気に入りへの追加", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) in
            })
            actionAlert.addAction(addAlbumAction)
        }

        
        
        let reportAction = UIAlertAction(title: "レポート", style: UIAlertActionStyle.default, handler: {
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

        
        let shareAction = UIAlertAction(title: "シェアする", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            let alertView = SCLAlertView()
            alertView.addButton("Twitter") {
                self.tweet()
            }
            alertView.showInfo("シェア", subTitle: "投稿を広める")
            
        })
        actionAlert.addAction(shareAction)

        
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセルをタップした時の処理")
        })
        // アクションを追加.
        actionAlert.addAction(cancelAction)
        
        self.present(actionAlert, animated: true, completion: nil)
    }
  
    // MARK: - GoOtherViews
    func goCommentView(){
        // 移動先のViewを定義する.
        let commentListlView: CommentListViewController = CommentListViewController()
        commentListlView.postsID = postID
        
        let btn_back = UIBarButtonItem()
        btn_back.title = ""
        self.navigationItem.backBarButtonItem = btn_back
        self.navigationController?.pushViewController(commentListlView, animated: true)
    }
    

    // MARK: - NetWorks
    func getPostInfo(postID:Int){
        
        Alamofire.request(EveryZooAPI.getPostsInfo(postID: postID)).responseJSON{
            response in
            
            switch response.result {
            case .success:
                let json:JSON = JSON(response.result.value ?? kill)
                
                self.postUserName = json["responce"]["userName"].stringValue
                self.postUserID = json["responce"]["userId"].intValue
                self.postTitle = json["responce"]["title"].stringValue
                self.postCaption = json["responce"]["caption"].stringValue
                self.postImgUrl = json["responce"]["imageInfo"]["image_url"].stringValue
                self.iconUrl = json["responce"]["iconUrl"].stringValue
                
                var dates:String = json["responce"]["updated_dates"]["year"].stringValue + "年"
                dates += json["responce"]["updated_dates"]["month"].stringValue + "月"
                dates += json["responce"]["updated_dates"]["day"].stringValue + "日 "
                dates += json["responce"]["updated_dates"]["hour"].stringValue + "時"
                dates += json["responce"]["updated_dates"]["minute"].stringValue + "分"
                self.pubDate = dates

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
        
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        myComposeView.setInitialText("#みんなの動物園")
        self.present(myComposeView, animated: true, completion: nil)
    }
}
