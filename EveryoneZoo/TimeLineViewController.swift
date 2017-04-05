//
//  TimeLineViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController {
    
    var statusHeight:CGFloat!
    var navBarHeight:CGFloat!
    var tabBarHeight:CGFloat!
    
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    
    var scrollViewHeight:CGFloat!
    
    var pictureScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        
        //ステータスバーの高さの取得
        statusHeight = UIApplication.shared.statusBarFrame.height
        
        //ナビゲーションバーのサイズの取得
        navBarHeight = 40
        
        //タブバーの高さの取得
        tabBarHeight = 40
        
        //スクロルビュー
        scrollViewHeight = viewHeight-(statusHeight+navBarHeight+tabBarHeight)
        
        setView()
        
        
        
        // ScrollViewを生成.
        pictureScrollView = UIScrollView()
        
        // ScrollViewの大きさを設定する.
        pictureScrollView.frame = CGRect(x: 0, y: statusHeight+navBarHeight, width: viewWidth, height: scrollViewHeight)
        
        // UIImageに画像を設定する.
        let examplePic = UIImage(named: "example_timeline")!
        
        // UIImageViewを生成する.
        let exampleImageView = UIImageView()
        
        // myImageViewのimageにmyImageを設定する.
        exampleImageView.image = examplePic
        
        // frameの値を設定する.
        exampleImageView.frame = pictureScrollView.frame
        
        // 画像のアスペクト比を設定.
        exampleImageView.contentMode = UIViewContentMode.scaleAspectFill
        
        // ScrollViewにmyImageViewを追加する.
        pictureScrollView.addSubview(exampleImageView)
        
        // Scrollの高さを計算しておく.
        let scroll_height = examplePic.size.height*(viewWidth/examplePic.size.width)
        
        // ScrollViewにcontentSizeを設定する.
        pictureScrollView.contentSize = CGSize(width:viewWidth, height:scroll_height)
        
        
        pictureScrollView.backgroundColor = UIColor.red
        // ViewにScrollViewをAddする.
        self.view.addSubview(pictureScrollView)

        
        // Do any additional setup after loading the view.
    }


    //Viewへの配置
    func setView() {
        
        //背景色を変更
        self.view.backgroundColor = UtilityLibrary.getZooThemeColor()
        
        //UINavigationBarを作成
        let myNavBar = UINavigationBar()
        
        //UINavigationBarの位置とサイズを指定
        myNavBar.frame = CGRect(x: 0, y: statusHeight, width: viewWidth, height: navBarHeight)
        
        //ナビゲーションバーの色を変える
        myNavBar.barTintColor = UtilityLibrary.getZooThemeColor()
        
        //ハイライトを消す
        myNavBar.isTranslucent = false
        
        //ナビゲーションボタンの色を変更する
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let myNavItems = UINavigationItem()
        myNavItems.title = "タイムライン"
        
        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(barButtonSystemItem:  .search, target: self, action: #selector(leftBarBtnClicked(sender:)))
        myNavItems.leftBarButtonItem = leftNavBtn
        
        //作成したNavItemをNavBarに追加する
        myNavBar.pushItem(myNavItems, animated: true)
        self.view.addSubview(myNavBar)
        
    }
    
    
    //左側のボタンが押されたら呼ばれる
    internal func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
    }

}
