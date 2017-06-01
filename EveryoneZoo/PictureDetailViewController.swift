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
        cell.userInfoBtn.addTarget(self, action: #selector(userInfoBtnClicked(sender:)), for:.touchUpInside)
        cell.followBtn.addTarget(self, action: #selector(followBtnClicked(sender:)), for:.touchUpInside)
        
        cell.userNameTextView.text = postUserName
        cell.descriptionTextView.text = self.postCaption
        cell.thumbnailImgView.af_setImage(withURL: self.iconUrl, placeholderImage:  UIImage(named:"tab_kabi")!)
        
        let loadImg = UIImage(named: "sample_loading")!
        cell.postImgView.af_setImage(withURL: self.postImgUrl, placeholderImage: loadImg)

        cell.menuBtn.addTarget(self, action: #selector(showActionShert(sender:)), for:.touchUpInside)

        return cell
    }
    
    //高さの設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        return 70
    }
    
    //Mark: - TableViewのボタンが押されたら呼ばれる
    //フォローボタンが押されたら呼ばれる
    func followBtnClicked(sender: FollowUserButton){
        
        sender.followImgView.image = UIImage(named: "tab_kabi")!
        //followImgView.image = UIImage(named: "userIcon")!
 

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
            // 移動先のViewを定義する.
            let commentListlView: CommentListViewController = CommentListViewController()
            self.navigationController?.pushViewController(commentListlView, animated: true)
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
