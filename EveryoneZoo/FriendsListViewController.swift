//
//  MyPageFollowViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class FriendsListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    
    private var tableViewHeight:CGFloat!
    
    //テーブルビューインスタンス
    private var friendsTableView: UITableView!
    
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
        
        //テーブルビューの初期化
        friendsTableView = UITableView()
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.separatorStyle = .none
        friendsTableView.allowsSelection = false
        friendsTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        friendsTableView.delaysContentTouches = true
        friendsTableView.canCancelContentTouches = true

        friendsTableView.register(FriendsFollowTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(FriendsFollowTableViewCell.self))
        friendsTableView.rowHeight = viewWidth*0.4
        self.view.addSubview(friendsTableView)
    }

    
    //basicボタンが押されたら呼ばれます
    func userBtnClicked(sender: UIButton){
        print("basicButtonBtnClicked")
        print(sender.tag)
    }
    
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "フレンズ"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return 8
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:FriendsFollowTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(FriendsFollowTableViewCell.self))! as! FriendsFollowTableViewCell


        cell.userBtnLeft.addTarget(self, action: #selector(userBtnClicked(sender:)), for:.touchUpInside)
        cell.userBtnCenter.addTarget(self, action: #selector(userBtnClicked(sender:)), for:.touchUpInside)
        cell.userBtnRight.addTarget(self, action: #selector(userBtnClicked(sender:)), for:.touchUpInside)
        
        cell.userBtnLeft.tag = indexPath.row*3
        cell.userBtnCenter.tag = indexPath.row*3+1
        cell.userBtnRight.tag = indexPath.row*3+2

        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
}
