//
//  PictureDetailViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import SCLAlertView

class PictureDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var postsID:Int!

    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!

    var tableViewHeight:CGFloat!
    
    //Post ID
    public var postID:Int!
    
    //Post Datas
    var postUserID:Int!
    var postUserName:String = ""
    var iconUrl:String = ""
    var postTitle:String = ""
    var postCaption:String = ""
    var commentList:Array<Any>!
    var favList:Array<Any>!
    var postImgUrl:URL!
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //view parts
    private var postDetailTableView: UITableView!
    
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
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        self.view.bringSubview(toFront: indicator)
        indicator.color = UIColor.mainAppColor()
        self.view.addSubview(indicator)
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
        
        //カスタムテーブルのボタン
        
        //UserInfoBtn
        let userInfoBtnWidth:CGFloat = viewWidth*0.65
        let userInfoBtnHeight:CGFloat = viewWidth*0.16
        cell.userInfoBtn.frame = CGRect(x: 0, y: 0, width: userInfoBtnWidth, height: userInfoBtnHeight)
        cell.userInfoBtn.addTarget(self, action: #selector(userInfoBtnClicked(sender:)), for:.touchUpInside)
        cell.thumbnailImgView.frame = CGRect(x: userInfoBtnHeight*0.15, y: userInfoBtnHeight*0.15, width: userInfoBtnHeight*0.7, height: userInfoBtnHeight*0.7)
        cell.thumbnailImgView.layer.cornerRadius = cell.thumbnailImgView.frame.height * 0.5
        if !self.iconUrl.isEmpty{
            cell.thumbnailImgView.af_setImage(withURL: URL(string:self.iconUrl)!, placeholderImage:  UIImage(named:"icon_default")!)
        }
        
        cell.userNameTextView.frame = CGRect(x: userInfoBtnHeight, y: 0, width: userInfoBtnWidth-userInfoBtnHeight, height: userInfoBtnHeight)
        cell.userNameTextView.text = postUserName

        //FollowBtn
        let followBtnWidth:CGFloat = viewWidth - userInfoBtnWidth
        let followBtnHeight:CGFloat = userInfoBtnHeight
        
        cell.followBtn.frame = CGRect(x: userInfoBtnWidth, y: 0, width: followBtnWidth, height: followBtnHeight)
        cell.followBtn.addTarget(self, action: #selector(followBtnClicked(sender:)), for:.touchUpInside)
        
        //PostImgView
        let postImgHeight:CGFloat = viewWidth
        cell.postImgView.frame = CGRect(x: 0, y: userInfoBtnHeight, width: viewWidth, height: postImgHeight)
        cell.postImgView.sd_setImage(with: self.postImgUrl, placeholderImage: UIImage(named: "sample_loading"))

        //FavBtn
        let favComentMenuBtnHeight:CGFloat = viewWidth * 0.15
        let favBtnSpace:CGFloat = viewWidth*0.05
        let favBtnWidth:CGFloat = viewWidth * 0.25
        cell.favBtn.frame = CGRect(x: favBtnSpace, y: userInfoBtnHeight+postImgHeight, width: favBtnWidth, height: favComentMenuBtnHeight)
        cell.favBtn.countLabel.text = String(self.favList.count)
        cell.favBtn.addTarget(self, action: #selector(favBtnClicked(sender:)), for:.touchUpInside)
        
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
        let dateLabelHeigt:CGFloat = viewHeight*0.05
        cell.dateLabel.frame = CGRect(x: viewWidth*0.05, y: userInfoBtnHeight+postImgHeight+favComentMenuBtnHeight, width: viewWidth*0.9, height: dateLabelHeigt)

        //DescriptionLabel
        let descriptionTextViewWidth:CGFloat = viewWidth*0.92
        cell.descriptionTextView.frame = CGRect(x: viewWidth*0.04, y: userInfoBtnHeight+postImgHeight+favComentMenuBtnHeight+dateLabelHeigt, width: descriptionTextViewWidth, height: 5)
        cell.descriptionTextView.text = self.postCaption
        cell.descriptionTextView.sizeToFit()

        
        return cell
    }
    
    //高さの設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        //ユーザーの高さ、viewWidth*0.16
        //投稿画像の高さ、可変、現在はviewWidth
        //コメントボタンなどの高さ、viewWidth * 0.15
        //日時のラベルの高さ、viewHeight*0.05
        //解説の高さ、可変
        //お尻に余白、viewHeight*0.05
        
        var cellHeight:CGFloat = viewWidth*(0.16+1+0.15+0.05+0.05)
        //高さを追加
        cellHeight += UtilityLibrary.calcTextViewHeight(text: self.postCaption, width: viewWidth*0.92, font: UIFont.systemFont(ofSize: 16))

        
        return cellHeight
    }
    
    //Mark: - Actions
    //フォローボタンが押されたら呼ばれる
    func followBtnClicked(sender: FollowUserButton){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if !(appDelegate.userDefaultsManager?.isLogin())! {
            //ログインしていない
            SCLAlertView().showInfo("ログインしてね", subTitle: "フォロー機能を使うにはログインが必要だよ！")
            return
        }
        
        if sender.followImgView.image == UIImage(named:"follow_icon") {
            sender.followImgView.image = UIImage(named: "follow_icon_on")!
            appDelegate.networkManager?.followUser(myUserId: 1, followUserId: 2)
            sender.followLabel.text = "フレンズ"
            
        }else{
            sender.followImgView.image = UIImage(named: "follow_icon")!
            appDelegate.networkManager?.unfollowUser(myUserId: 1, followUserId: 2)
            sender.followLabel.text = "フォロー"
        }
    }
    
    //ファボボタンが押されたら呼ばれる
    func favBtnClicked(sender: FavCommentButton){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if !(appDelegate.userDefaultsManager?.isLogin())! {
            //ログインしていない
            SCLAlertView().showInfo("ログインしてね", subTitle: "お気に入り機能を使うにはログインが必要だよ！")
            return
        }
        
        if sender.imgView.image == UIImage(named:"fav_on") {
            sender.imgView.image = UIImage(named: "fav_off")!
            sender.countLabel.text = "24"
            sender.countLabel.textColor = UIColor.black
            
        }else{
            sender.imgView.image = UIImage(named: "fav_on")!
            sender.countLabel.text = "25"
            sender.countLabel.textColor = UIColor.followColor()
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
        self.navigationController?.pushViewController(userInfoView, animated: true)
    }
    
    //Mark: コメント投稿画面への遷移
    func showActionShert(sender: UIButton){
        
        // インスタンス生成　styleはActionSheet.
        let actionAlert = UIAlertController(title: "操作メニュー", message: "操作を選んでください。", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.userDefaultsManager?.isLogin())! {
            
            // アクションを生成.
            let commentAction = UIAlertAction(title: "コメント", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) in
                // コメント画面へ遷移
                self.goCommentView()
            })
            actionAlert.addAction(commentAction)

            
            let addAlbumAction = UIAlertAction(title: "アルバムへの追加", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) in
            })
            actionAlert.addAction(addAlbumAction)
        }

        
        
        let reportAction = UIAlertAction(title: "レポート", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
        })
        actionAlert.addAction(reportAction)

        
        let shareAction = UIAlertAction(title: "共有する", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
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
        self.navigationController?.pushViewController(commentListlView, animated: true)
    }
    
    

    // MARK: - NetWorks
    func getPostInfo(postID:Int){
        
        Alamofire.request(APP_URL+GET_POSTS_DATAILS+String(postID)).responseJSON{
            response in
            
            switch response.result {
            case .success:
                //print("投稿JSON取得成功")
                let json:JSON = JSON(response.result.value ?? kill)
                
                print(json)
                
                self.postUserName = json[0]["userName"].stringValue
                self.postUserID = json[0]["userId"].intValue
                self.postTitle = json[0]["title"].stringValue
                self.postCaption = json[0]["caption"].stringValue
                self.postImgUrl = URL(string: json[0]["itemImage"].stringValue)!
                
                if !json[0]["iconUrl"].stringValue.isEmpty{
                    self.iconUrl = json[0]["iconUrl"].stringValue
                }
                

                self.commentList = json[0]["commentList"].arrayValue
                self.favList = json[0]["favList"].arrayValue

                self.setNavigationBar()
                self.setTableView()
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
