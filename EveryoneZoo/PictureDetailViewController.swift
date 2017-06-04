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


class PictureDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    //width, height
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    var tableViewHeight:CGFloat!
    
    //Post ID
    public var postID:Int!
    
    //Post Datas
    var postUserID:Int!
    var postUserName:String = ""
    var iconUrl:URL!
    var postTitle:String = ""
    var postCaption:String = ""
    var postImgUrl:URL = URL(string: "http://www.tokyo-zoo.net/Topics/upfiles/24152_top.jpg")!
    
    
    //view parts
    private var postDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        tableViewHeight = viewHeight-(PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR+PARTS_TABBAR_HEIGHT)
        
        //投稿の情報の取得
        getPostInfo(postID: self.postID)
        
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: NavigationBar
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
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
        cell.thumbnailImgView.af_setImage(withURL: self.iconUrl, placeholderImage:  UIImage(named:"tab_kabi")!)
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
        cell.postImgView.af_setImage(withURL: self.postImgUrl, placeholderImage: UIImage(named: "sample_loading")!)

        
        //FavBtn
        let favComentMenuBtnHeight:CGFloat = viewWidth * 0.15
        let favBtnSpace:CGFloat = viewWidth*0.05
        let favBtnWidth:CGFloat = viewWidth * 0.25
        cell.favBtn.frame = CGRect(x: favBtnSpace, y: userInfoBtnHeight+postImgHeight, width: favBtnWidth, height: favComentMenuBtnHeight)
        
        //CommentBtn
        let commentBtn:CGFloat = favBtnWidth
        cell.commentBtn.frame = CGRect(x: favBtnSpace+favBtnWidth, y: userInfoBtnHeight+postImgHeight, width: commentBtn, height: favComentMenuBtnHeight)
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
        let descriptionTextViewHeight:CGFloat = viewWidth*0.2
        cell.descriptionTextView.text = self.postCaption
        cell.descriptionTextView.frame = CGRect(x: viewWidth*0.04, y: userInfoBtnHeight+postImgHeight+favComentMenuBtnHeight+dateLabelHeigt, width: descriptionTextViewWidth, height: descriptionTextViewHeight)

        
        return cell
    }
    
    //高さの設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        return viewWidth*1.65
    }
    
    //Mark: - Actions
    //フォローボタンが押されたら呼ばれる
    func followBtnClicked(sender: FollowUserButton){
        
        if sender.followImgView.image == UIImage(named:"follow_icon") {
            sender.followImgView.image = UIImage(named: "follow_icon_on")!
        }else{
            sender.followImgView.image = UIImage(named: "follow_icon")!
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
        userInfoView.postUserName = self.postUserName
        self.navigationController?.pushViewController(userInfoView, animated: true)
    }
    
    //Mark: コメント投稿画面への遷移
    func showActionShert(sender: UIButton){
        // インスタンス生成　styleはActionSheet.
        let actionAlert = UIAlertController(title: "アクション", message: "アクションを選んでください。", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // アクションを生成.
        let commentAction = UIAlertAction(title: "コメント", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            // コメント画面へ遷移
            self.goCommentView()
        })
        
        let shareAction = UIAlertAction(title: "共有する", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
        })
        
        let editTagAction = UIAlertAction(title: "タグの編集", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
        })
        
        let addAlbumAction = UIAlertAction(title: "アルバムへの追加", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
        })
        
        let reportAction = UIAlertAction(title: "レポート", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
        })
        
        let otherAction = UIAlertAction(title: "その他", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
        })
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセルをタップした時の処理")
        })
        // アクションを追加.
        actionAlert.addAction(commentAction)
        actionAlert.addAction(shareAction)
        actionAlert.addAction(editTagAction)
        actionAlert.addAction(addAlbumAction)
        actionAlert.addAction(reportAction)
        actionAlert.addAction(otherAction)
        actionAlert.addAction(cancelAction)
        
        self.present(actionAlert, animated: true, completion: nil)
    }
    
    
    // MARK: - GoOtherViews
    func goCommentView(){
        // 移動先のViewを定義する.
        let commentListlView: CommentListViewController = CommentListViewController()
        self.navigationController?.pushViewController(commentListlView, animated: true)
    }
    
    

    // MARK: - NetWorks
    func getPostInfo(postID:Int){
        
        let urlStr:String = "http://minzoo.herokuapp.com/api/v0/plaza/detail/"+String(postID)

        Alamofire.request(urlStr).responseJSON{
            response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
                let json:JSON = JSON(response.result.value ?? kill)
                
                self.postUserName = json[0]["userName"].stringValue
                self.postUserID = json[0]["userId"].intValue
                self.postTitle = json[0]["title"].stringValue
                self.postCaption = json[0]["caption"].stringValue
                self.postImgUrl = URL(string: json[0]["itemImage"].stringValue)!
                
                self.getUserInfo(userID:self.postUserID)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
    func getUserInfo(userID:Int){
        
        let urlStr:String = "http://minzoo.herokuapp.com/api/v0/users/"+String(userID)

        
        Alamofire.request(urlStr).responseJSON{
            response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
                let json:JSON = JSON(response.result.value ?? kill)
                
                self.iconUrl = URL(string: json["iconUrl"].stringValue)!
                self.setNavigationBar()
                self.setTableView()
                
            case .failure(let error):
                print(error)
                
                
            }
        }
        
    }
    

    // MARK: - Others
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
