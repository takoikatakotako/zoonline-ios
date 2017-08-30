//
//  CommentListViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/26.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import SDWebImage

class CommentListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    var postsID:Int!
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    var tableViewHeight:CGFloat!
    
    //テーブルビューインスタンス
    private var commentTableView: UITableView!
    private var postsComments:JSON = []
    
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
        
        getPostsComments()
    }

    // MARK: - Viewにパーツの設置
    // MARK: NavigationBar
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "コメント一覧"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if !(appDelegate.userDefaultsManager?.isLogin())! {
            //ログインしていない
            return
        }else{
            //バーの右側に設置するボタンの作成
            let rightNavBtn = UIBarButtonItem()
            rightNavBtn.image = UIImage(named:"submit_nav_btn")!
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
    
    
    func getPostsComments() {
        
        Alamofire.request(APP_URL + GETS_POSTS + String(postsID) + COMMENTS).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                self.postsComments = json["comments"]
                
                //print(self.postsComments)
                self.commentTableView.reloadData()
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }
    
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsComments.count
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CommentTableViewCell.self), for: indexPath) as! CommentTableViewCell
        cell.thumbnailImgView.image = UIImage(named:"sample_kabi1")
        print(self.postsComments["comment"])
        cell.commentLabel.text = self.postsComments[indexPath.row]["comment"].stringValue
        
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
    
    
    // MARK: -
    func goWriteCommentView(sender: UIButton){
        
    }
}
