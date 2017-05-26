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
        postDetailTableView.rowHeight = viewWidth*1.65
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
        
        //カスタムパーツ
        cell.userInfoBtn.addTarget(self, action: #selector(userInfoBtnClicked(sender:)), for:.touchUpInside)
        
        cell.userNameTextView.text = postUserName
        cell.descriptionTextView.text = self.postCaption
        cell.thumbnailImgView.af_setImage(withURL: self.iconUrl, placeholderImage:  UIImage(named:"tab_kabi")!)
        
        let loadImg = UIImage(named: "sample_loading")!
        cell.postImgView.af_setImage(withURL: self.postImgUrl, placeholderImage: loadImg)

        cell.menuBtn.addTarget(self, action: #selector(showActionShert(sender:)), for:.touchUpInside)

        return cell
    }
    
    //Mark: コメント投稿画面への遷移
    func userInfoBtnClicked(sender: UIButton){
        
        //画面遷移、投稿詳細画面へ
        let picDetailView: UserInfoViewController = UserInfoViewController()
        picDetailView.postUserID = self.postUserID
        picDetailView.postUserName = self.postUserName
        self.navigationController?.pushViewController(picDetailView, animated: true)        
    }
    
    //Mark: コメント投稿画面への遷移
    func showActionShert(sender: UIButton){
        // インスタンス生成　styleはActionSheet.
        let myAlert = UIAlertController(title: "アクション", message: "アクションを選んでください。", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // アクションを生成.
        let myAction_1 = UIAlertAction(title: "コメント", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("Hello")
            // 移動先のViewを定義する.
            let commentListlView: CommentListViewController = CommentListViewController()
            // SecondViewに移動する.
            self.navigationController?.pushViewController(commentListlView, animated: true)
        })
        
        let myAction_2 = UIAlertAction(title: "共有する", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("yes")
        })
        
        let myAction_3 = UIAlertAction(title: "マイアルバムへの追加", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("no")
        })
        
        // アクションを追加.
        myAlert.addAction(myAction_1)
        myAlert.addAction(myAction_2)
        myAlert.addAction(myAction_3)
        
        self.present(myAlert, animated: true, completion: nil)
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
