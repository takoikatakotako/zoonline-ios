//
//  CommentListViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/26.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import SCLAlertView

class CommentListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    var postsID: Int!
    
    //width, height
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    private var statusBarHeight: CGFloat!
    private var navigationBarHeight: CGFloat!
    private var tabBarHeight: CGFloat!
    var tableViewHeight: CGFloat!
    
    //テーブルビューインスタンス
    private var commentTableView: UITableView!
    private var postsComments: JSON = []
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+tabBarHeight)
        
        setNavigationBar()
        
        setTableView()
        
        setActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        indicator.startAnimating()
        getPostsComments()
    }
    

    // MARK: - Viewにパーツの設置
    // MARK: NavigationBar
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(named: "main")
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel: NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "コメント一覧"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel

        if !(UtilityLibrary.isLogin()) {
            //ログインしていない
            return
        }else{
            //バーの右側に設置するボタンの作成
            let rightNavBtn = UIBarButtonItem()
            rightNavBtn.image = UIImage(named: "submit_nav_btn")!
            rightNavBtn.action = #selector(goWriteCommentView(sender:))
            rightNavBtn.target = self
            self.navigationItem.rightBarButtonItem = rightNavBtn
        }
    }
    
    // MARK: TableView
    func setTableView() {
        
        commentTableView = UITableView()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        commentTableView.rowHeight = viewWidth*0.28
        commentTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(CommentTableViewCell.self))
        self.view.addSubview(commentTableView)
    }
    
    // MARK: くるくるの生成
    func setActivityIndicator(){
        
        indicator.frame = CGRect(x: viewWidth*0.35, y: viewHeight*0.25, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        indicator.color = UIColor.init(named: "main")
        self.view.bringSubviewToFront(indicator)
        indicator.color = UIColor.init(named: "main")
        self.view.addSubview(indicator)
    }
    
    func getPostsComments() {

        Alamofire.request(EveryZooAPI.getComments(postID: postsID)).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json: JSON = JSON(response.result.value ?? kill)
                print(json)
                self.postsComments = json["comments"]
                
                self.indicator.stopAnimating()
                self.commentTableView.reloadData()
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }
    
    
    func deleatePostComment(commentID: Int) {
        
        print(EveryZooAPI.deleateComments(commentID: commentID))
        
        let parameters: Parameters = [
            "comment_id": commentID
        ]
        
        print(EveryZooAPI.deleateComments(commentID: commentID))
        
        
        Alamofire.request(EveryZooAPI.deleateComments(commentID: commentID), method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json: JSON = JSON(response.result.value ?? kill)
                if json["is_success"].boolValue {
                    SCLAlertView().showInfo("コメント削除", subTitle: "コメントを削除しました")
                    self.indicator.startAnimating()
                    self.getPostsComments()
                }else{
                    SCLAlertView().showInfo("エラー", subTitle: "不明なエラーです")
                }
                
            case .failure(let error):
                print(error)
                SCLAlertView().showInfo("エラー", subTitle: "インターネットの接続を確認してください")
            }
        }
    }
    
    
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsComments.count
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CommentTableViewCell.self), for: indexPath) as! CommentTableViewCell

        let iconUrlStr: String = self.postsComments[indexPath.row]["icon_url"].stringValue
        print(iconUrlStr)
        if let url = URL(string: iconUrlStr) {
            cell.thumbnail.sd_setImage(with: url)
        }
        
        let dates = UtilityLibrary.parseDates(text: self.postsComments[indexPath.row]["updated_at"].stringValue)
        var dateStr = dates["year"]! + "年" + dates["month"]! + "月"
        dateStr += dates["day"]! + "日"
        cell.dateLabel.text = dateStr
        
        cell.commentTextView.text = self.postsComments[indexPath.row]["comment"].stringValue
     
        cell.userName.text = self.postsComments[indexPath.row]["username"].stringValue
        
        //画像にタッチイベントを追加
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(sender:)))
        singleTap.numberOfTapsRequired = 1
        cell.thumbnail.tag = self.postsComments[indexPath.row]["user_id"].intValue
        cell.thumbnail.addGestureRecognizer(singleTap)
        
        return cell
    }
    
    
    
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        tableView.deselectRow(at: indexPath, animated: true)
        print(postsComments[indexPath.row]["user_id"].stringValue)
        if postsComments[indexPath.row]["user_id"].stringValue == UtilityLibrary.getUserID(){
            let alertView = SCLAlertView()
            alertView.addButton("削除") {
                let commentID = self.postsComments[indexPath.row]["comment_id"].intValue
                self.deleatePostComment(commentID: commentID)
            }
            alertView.showInfo("コメント削除", subTitle: "このコメントを削除しますか？")
        }
    }
    
    
    //高さの設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        
        var cellHeight: CGFloat = viewWidth*0.28 * 0.66
        cellHeight+=UtilityLibrary.calcTextViewHeight(text: self.postsComments[indexPath.row]["comment"].stringValue, width: viewWidth*0.8, font: UIFont.systemFont(ofSize: 12))
        
        if cellHeight > viewWidth * 0.28 {
            return cellHeight
        }else{
            return viewWidth * 0.28
        }        
    }
    
    
    //MARK: シングルタップ時に実行される
    @objc func tapSingle(sender: UITapGestureRecognizer) {
        print(sender.view?.tag ?? 1)
        
        //画面遷移を行う

        let userInfoView: UserInfoVC = UserInfoVC()
        userInfoView.postUserID = sender.view?.tag
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(userInfoView, animated: true)
    }
    
    
    // MARK: -
    @objc func goWriteCommentView(sender: UIButton){
        
        let wirtePostCommentsVC: WritePostsCommentsViewController = WritePostsCommentsViewController()
        wirtePostCommentsVC.postsID = postsID

        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(wirtePostCommentsVC, animated: true)
    }
}
