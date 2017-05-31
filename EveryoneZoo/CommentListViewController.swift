//
//  CommentListViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/26.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class CommentListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    
    //width, height
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    var tableViewHeight:CGFloat!
    
    //テーブルビューインスタンス
    private var commentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        tableViewHeight = viewHeight - (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR+PARTS_TABBAR_HEIGHT)
        
        setNavigationBar()
        setTableView()
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
        titleLabel.text = "コメント一覧画面"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
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
    
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //myItems配列の中身をテキストにして登録した
        let cell:CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CommentTableViewCell.self), for: indexPath) as! CommentTableViewCell
        cell.thumbnailImgView.image = UIImage(named:"sample_kabi1")

        //cell.textLabel?.text = "サイさん、とても大きいです、、、、///"
        //cell.thumbnailImgView.image = UIImage
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }
}
