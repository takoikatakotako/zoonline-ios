//
//  NewsListViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/09.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

protocol SampleDelegate: class  {
    func changeBackgroundColor(color:UIColor)
}

class NewsListViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    //
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    var statusBarHeight:CGFloat!
    var navigationBarHeight:CGFloat!
    var pageMenuHeight:CGFloat!
    var tabBarHeight:CGFloat!
    private var tableViewHeight:CGFloat!

    //delegate
    weak var delegate: SampleDelegate?
    
    
    //テーブルビューインスタンス
    private var newsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        tableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+pageMenuHeight+tabBarHeight)
        
        //テーブルビューの初期化
        newsTableView = UITableView()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: tableViewHeight)
        newsTableView.register(MyPagePostCell.self, forCellReuseIdentifier: NSStringFromClass(MyPagePostCell.self))
        newsTableView.rowHeight = viewWidth*0.28
        self.view.addSubview(newsTableView)
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
        delegate?.changeBackgroundColor(color: UIColor.red)
    }
}
