//
//  UserInfoViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/26.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    
    //テーブルビューインスタンス
    private var myTableView: UITableView!
    
    //テーブルビューに表示する配列
    private var myItems: NSArray = []
    
    //width, height
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    
    //UserInfo
    //ユーザーIDとユーザー名は受け取る
    var postUserID:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        
        self.view.backgroundColor = UIColor.white
    
        setNavigationBar()
        
        let profileView:UIView = UIView()
        profileView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth*0.65)
        profileView.backgroundColor = UIColor.gray
        self.view.addSubview(profileView)
        
        let profileIconViewWidth:CGFloat = viewWidth*0.24
        let profileIcon:UIImageView = UIImageView()
        profileIcon.frame = CGRect(x: viewWidth/2-profileIconViewWidth/2, y: viewWidth*0.65*0.1, width: profileIconViewWidth, height: profileIconViewWidth)
        profileIcon.image = UIImage(named:"icon_default")
        self.view.addSubview(profileIcon)
        
        let profileName:UILabel = UILabel()
        profileName.text = "どうけん"
        profileName.frame = CGRect(x: 0, y: viewWidth*0.65*0.5, width: viewWidth, height: 40)
        profileName.textAlignment = NSTextAlignment.center
        profileName.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(profileName)
        
        let profileText:UILabel = UILabel()
        profileText.text = "わたしはサーバルキャットのサーバル！かりごっこが大好きなんだ〜"
        profileText.frame = CGRect(x: viewWidth*0.05, y: viewWidth*0.65*0.6, width: viewWidth*0.9, height: viewWidth*0.65*0.4)
        profileText.numberOfLines = 0
        profileText.textAlignment = NSTextAlignment.center
        profileText.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(profileText)
        
        //テーブルビューに表示する配列
        myItems = ["りんご", "すいか", "もも", "さくらんぼ", "ぶどう", "なし"]
        
        
        //テーブルビューの初期化
        myTableView = UITableView()
        
        //デリゲートの設定
        myTableView.delegate = self
        myTableView.dataSource = self
        
        //テーブルビューの大きさの指定
        myTableView.frame = CGRect(x: 0, y: viewWidth*0.65, width: viewWidth, height: viewHeight-viewWidth*0.65-(statusBarHeight+tabBarHeight+navigationBarHeight))
        
        //テーブルビューの設置
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(myTableView)
        
    }
    
    // MARK: NavigationBar
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "プロフィール"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
    }
    
    
    
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return self.myItems.count
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = self.myItems[indexPath.row] as? String
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
    
}
