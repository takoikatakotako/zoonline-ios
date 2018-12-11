//
//  MyPageFavoriteViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import SCLAlertView

class MyPageFavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userID: Int!

    //width, height
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    private var statusBarHeight: CGFloat!
    private var navigationBarHeight: CGFloat!
    private var tabBarHeight: CGFloat!
    
    private var tableViewHeight: CGFloat!
    
    var favoriteListTableView: UITableView!
    private var favoritePosts: JSON = []
    
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
        
        favoriteListTableView = UITableView()
        favoriteListTableView.delegate = self
        favoriteListTableView.dataSource = self
        favoriteListTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        favoriteListTableView.rowHeight = viewWidth*0.28
        
        //テーブルビューの設置
        favoriteListTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        self.view.addSubview(favoriteListTableView)
        
        getMyFavoritePosts()
    }
    
    func getMyFavoritePosts() {
        
        Alamofire.request(EveryZooAPI.getFavoritePosts(userID: userID)).responseJSON { response in
            
            switch response.result {
            case .success:
                
                let json: JSON = JSON(response.result.value ?? kill)
                print(json)
                
                if json["is_success"].boolValue {
                
                    self.favoritePosts = json["responce"]
                    self.favoriteListTableView.reloadData()
                }else {
                    SCLAlertView().showInfo("エラー", subTitle: "お気に入りの投稿の取得に失敗しました。")
                }
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }

    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(named: "main")
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel: NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "お気に入り"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }
    
    
    // MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return self.favoritePosts.count
    }
    
    // MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self))! as! MyPagePostCell
        let dates = UtilityLibrary.parseDates(text: self.favoritePosts[indexPath.row]["created_at"].stringValue)
        var dateText: String = dates["year"]! + "/"
        dateText += dates["month"]! + "/"
        dateText += dates["day"]!
        cell.dateLabel.text = dateText

        cell.titleLabel.text = self.favoritePosts[indexPath.row]["title"].stringValue
        cell.commentLabel.text = self.favoritePosts[indexPath.row]["caption"].stringValue
        
        let imageUrlText = self.favoritePosts[indexPath.row]["image_url"].stringValue
        if let imageUrl = URL(string: imageUrlText) {
            cell.thumbnailImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample_loading"))
        }
        return cell
    }
    
    // MARK: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //画面遷移、投稿詳細画面へ
        let picDetailView: PostDetailViewController = PostDetailViewController()
        //picDetailView.postID = self.favoritePosts[indexPath.row]["id"].intValue
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
}
