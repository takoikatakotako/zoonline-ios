//
//  TempPictureViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/20.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class TempTimeLineViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    private var tableViewHeight:CGFloat!

    private var newsTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        //Viewの大きさを取得
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+tabBarHeight!)
        
        setNavigationBarBar()
        
        
        
        //テーブルビューの初期化
        newsTableView = UITableView()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        newsTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        newsTableView.rowHeight = viewWidth*0.28
        self.view.addSubview(newsTableView)
    }


    // MARK: - Viewにパーツの設置
    // MARK: NavigationBarの設置
    func setNavigationBarBar(){
        
        let myBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = myBackButton
        
        //UINavigationBarの位置とサイズを指定
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: statusBarHeight, width: viewWidth, height: navigationBarHeight)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "タイムライン"
    }
    

    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return 13
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:MyPagePostCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self), for: indexPath) as! MyPagePostCell
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        
        //デリゲートを用いて初めのViewの色をランダムに変える
        goDetailView(postID: 3)
    }
    func goDetailView(postID:Int) {
        //画面遷移、投稿詳細画面へ
        let picDetailView: PictureDetailViewController = PictureDetailViewController()
        picDetailView.postID = postID
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
}
