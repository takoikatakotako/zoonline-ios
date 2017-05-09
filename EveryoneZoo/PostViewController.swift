//
//  PostViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    //width, height
    private var statusHeight:CGFloat!
    private var navBarHeight:CGFloat!
    private var segmentViewHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var tableViewHeight:CGFloat!
    
    //view parts
    private var pictureTableView: UITableView!
    @IBOutlet weak var serchNavBtn: UIBarButtonItem!
    

    //テーブルビューインスタンス
    private var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        
        
        //各部品の高さを取得
        statusHeight = UIApplication.shared.statusBarFrame.height
        navBarHeight =  self.navigationController?.navigationBar.frame.height
        segmentViewHeight = self.navigationController?.navigationBar.frame.height
        tabBarHeight = UITabBar.appearance().frame.size.height
        //tableViewHeight = viewHeight-(statusHeight+navBarHeight+segmentViewHeight+tabBarHeight+tabBarHeight)
        
        
        
        //ステータスバー部分の背景
        let statusBackColor = UIView()
        statusBackColor.frame = CGRect(x: 0, y: 0, width: viewWidth, height: 60)
        statusBackColor.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusBackColor)
        

        setView()
    }
    
    func setView() {
        
        //ナビゲーションバーの作成
        let myNavBar:ZooNavigationBar = ZooNavigationBar()
        myNavBar.frame = CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR, width: viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR)
        
        
        
        myNavBar.myView.backgroundColor = UIColor.blue
        
        
        //ナビゲーションボタンの色を変更する
        //UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let myNavItems = UINavigationItem()
        //myNavItems.titleLabe.text = "バーのタイトル"
        
        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(barButtonSystemItem:  .add, target: self, action: #selector(leftBarBtnClicked(sender:)))
        myNavItems.leftBarButtonItem = leftNavBtn
        
        //バーの右側に設置するボタンの作成
        let rightNavBtn = UIBarButtonItem()
        
        //ボタンにする画像を選択する
        let rightNavBtnImg:UIImage = UIImage(named:"tab_kabi")!
        rightNavBtn.image = rightNavBtnImg
        
        //ボタンが押され時のアクションを設定する
        rightNavBtn.action = #selector(rightBarBtnClicked(sender:))
        myNavItems.rightBarButtonItem = rightNavBtn;
        
        //作成したNavItemをNavBarに追加する
        myNavBar.pushItem(myNavItems, animated: true)
        self.view.addSubview(myNavBar)
        
        
        //UIScrollView
        let scrollView:UIScrollView = UIScrollView()
        scrollView.frame =  CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR, width: viewWidth, height: 300)
        scrollView.backgroundColor = UIColor.gray
        //self.view.addSubview(scrollView)
    }
    
    //左側のボタンが押されたら呼ばれる
    internal func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
    }
    
    //右側のボタンが押されたら呼ばれる
    internal func rightBarBtnClicked(sender: UIButton){
        print("rightBarBtnClicked")
    }

}
