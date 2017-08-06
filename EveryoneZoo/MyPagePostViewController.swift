//
//  MyPagePostViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class MyPagePostViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var tableViewHeight:CGFloat!
    
    //テーブルビューインスタンス
    private var postListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        tableViewHeight = viewHeight - (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR+PARTS_TABBAR_HEIGHT)
        
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
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "投稿一覧"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }
    
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //テーブルビューのセルの数はmyItems配列の数とした
        return 12
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyPagePostCell.self))! as UITableViewCell
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
}
