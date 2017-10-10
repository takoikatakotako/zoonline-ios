//
//  MyPagePostViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import SDWebImage

class MyPagePostViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var userID:Int!

    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    private var tableViewHeight:CGFloat!
    
    //テーブルビューインスタンス
    private var postListTableView: UITableView!
    private var postsContents:JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+tabBarHeight)
        
        self.view.backgroundColor = UIColor.white

        setNavigationBar()
        
        postListTableView = UITableView()
        postListTableView.delegate = self
        postListTableView.dataSource = self
        postListTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        postListTableView.rowHeight = viewWidth*0.28
        
        //テーブルビューの設置
        postListTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        self.view.addSubview(postListTableView)
        
        //
        getMyPosts()
    }
    
    func getMyPosts() {
        
        Alamofire.request(EveryZooAPI.getUserPosts(userID: userID)).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                self.postsContents = json
                
                self.postListTableView.reloadData()
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "投稿一覧"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }
    
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return postsContents.count
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self))! as! MyPagePostCell
        var dateText:String = self.postsContents[indexPath.row]["created_at"].stringValue
        dateText = dateText.substring(to: dateText.index(dateText.startIndex, offsetBy: 10))
        cell.dateLabel.text = dateText
        cell.titleLabel.text = self.postsContents[indexPath.row]["title"].stringValue
        cell.commentLabel.text = self.postsContents[indexPath.row]["caption"].stringValue
        let imageUrl = URL(string:self.postsContents[indexPath.row]["image_url"].stringValue)!
        cell.thumbnailImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample_loading"))

        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //画面遷移、投稿詳細画面へ
        let picDetailView: PictureDetailViewController = PictureDetailViewController()
        picDetailView.postID = self.postsContents[indexPath.row]["id"].intValue
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
}
