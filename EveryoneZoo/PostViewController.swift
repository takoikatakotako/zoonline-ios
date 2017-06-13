//
//  PostViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostViewController: UIViewController {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var scrollViewHeight:CGFloat!

    //テーブルビューインスタンス
    private var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        scrollViewHeight = viewHeight - PARTS_HEIGHT_STATUS_BAR - PARTS_HEIGHT_NAVIGATION_BAR
        
        setNavigationBar()
        
        let postScrollView:PostViewScrollView = PostViewScrollView(frame:CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR + PARTS_HEIGHT_NAVIGATION_BAR, width: viewWidth, height: scrollViewHeight))
        self.view.addSubview(postScrollView)
        
    }
    

    
    func setNavigationBar() {
        
        //ステータスバー背景
        let statusBackColor = UIView()
        statusBackColor.frame = CGRect(x: 0, y: 0, width: viewWidth, height: PARTS_HEIGHT_STATUS_BAR)
        statusBackColor.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusBackColor)
        
        //ナビゲーションバーの作成
        UINavigationBar.appearance().tintColor = UIColor.white
        let myNavBar = UINavigationBar()
        myNavBar.frame = CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR, width: viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR)
        myNavBar.barTintColor = UIColor.mainAppColor()
        myNavBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let myNavItems = UINavigationItem()
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "投稿する"
        titleLabel.textColor = UIColor.white
        myNavItems.titleView = titleLabel
        
        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(title: "リセット", style: .plain, target: self, action:  #selector(leftBarBtnClicked(sender:)))
        myNavItems.leftBarButtonItem = leftNavBtn
        
        //バーの右側に設置するボタンの作成
        let rightNavBtn = UIBarButtonItem(title: "投稿", style: .plain, target: self, action:  #selector(postBtnClicked(sender:)))
        myNavItems.rightBarButtonItem = rightNavBtn;
        
        //作成したNavItemをNavBarに追加する
        myNavBar.pushItem(myNavItems, animated: true)
        self.view.addSubview(myNavBar)
    }

    
    
    //左側のボタンが押されたら呼ばれる
    internal func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //右側のボタンが押されたら呼ばれる
    internal func postBtnClicked(sender: UIButton){
        

    }

}
