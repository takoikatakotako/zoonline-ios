//
//  PictureViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/17.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit


class PictureViewController: UIViewController {
    
    
    var statusHeight:CGFloat!
    var navBarHeight:CGFloat!
    var tabBarHeight:CGFloat!
    
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    
    
    private var pictureScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        
        //ステータスバーの高さの取得
        statusHeight = UIApplication.shared.statusBarFrame.height
        
        //ナビゲーションバーのサイズの取得
        navBarHeight = 40

        //タブバーの高さの取得
        tabBarHeight = 40
        
        setView()
        
        

        // ScrollViewを生成.
        pictureScrollView = UIScrollView()
        
        // ScrollViewの大きさを設定する.
        pictureScrollView.frame = CGRect(x: 0, y: statusHeight+navBarHeight, width: viewWidth, height: viewWidth-(statusHeight+navBarHeight+tabBarHeight))
        
        
        /*
        // UIImageに画像を設定する.
        let myImage = UIImage(named: "temple.jpg")!
        
        // UIImageViewを生成する.
        let myImageView = UIImageView()
        
        // myImageViewのimageにmyImageを設定する.
        myImageView.image = myImage
        
        // frameの値を設定する.
        myImageView.frame = myScrollView.frame
        
        // 画像のアスペクト比を設定.
        myImageView.contentMode = UIViewContentMode.scaleAspectFill
        
        // ScrollViewにmyImageViewを追加する.
        myScrollView.addSubview(myImageView)
        
        // Scrollの高さを計算しておく.
        let scroll_height = myImage.size.height*(self.view.frame.width/myImage.size.width)
        
        // ScrollViewにcontentSizeを設定する.
        myScrollView.contentSize = CGSize(width:self.view.frame.width, height:scroll_height)
        */
        // ViewにScrollViewをAddする.
        self.view.addSubview(pictureScrollView)
 
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
        myNavItems.title = "ひろば"
        
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
