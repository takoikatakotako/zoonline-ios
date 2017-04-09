//
//  TimeLineViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController {
    
    private var statusHeight:CGFloat!
    private var navBarHeight:CGFloat!
    private var segmentViewHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    var scrollViewHeight:CGFloat!
    
    //view parts
    private var segmentView:UIView!
    var pictureScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        
        //ステータスバーの高さの取得
        statusHeight = UIApplication.shared.statusBarFrame.height
        
        //ナビゲーションバーのサイズの取得
        navBarHeight =  self.navigationController?.navigationBar.frame.height
        
        segmentViewHeight = self.navigationController?.navigationBar.frame.height
        //タブバーの高さの取得
        tabBarHeight = UITabBar.appearance().frame.size.height
        
        //スクロルビュー
        scrollViewHeight = viewHeight-(statusHeight+navBarHeight+tabBarHeight)
        
        setView()
        
        setSegmentView()

        
        /*
        
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

        */
    }


    //Viewへの配置
    func setView() {
        
        //背景色を変更
        self.view.backgroundColor = UIColor.mainAppColor()

        //UINavigationBarの位置とサイズを指定
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: statusHeight, width: viewWidth, height: navBarHeight)
        
        //ナビゲーションバーの色を変える
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        
        //ハイライトを消す
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションボタンの色を変更する
        UINavigationBar.appearance().tintColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = "タイムライン"
        
        /*
        //ナビゲーションアイテムを作成
        let myNavItems = UINavigationItem()
        myNavItems.title = "タイムライン"
        
        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(barButtonSystemItem:  .search, target: self, action: #selector(leftBarBtnClicked(sender:)))
        myNavItems.leftBarButtonItem = leftNavBtn
        
        //作成したNavItemをNavBarに追加する
        myNavBar.pushItem(myNavItems, animated: true)
        self.view.addSubview(myNavBar)
        */
    }
    
    
    func setSegmentView(){
        
        // MARK: - segmentView
        segmentView = UIView()
        segmentView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: segmentViewHeight)
        segmentView.backgroundColor = UIColor.white
        self.view.addSubview(segmentView)
        
        //スクロールビューとの区切り線
        let segmentLine = UIView()
        segmentLine.frame = CGRect(x: 0, y: segmentViewHeight - 2, width: viewWidth, height: 2)
        segmentLine.backgroundColor = UIColor.gray
        segmentView.addSubview(segmentLine)
        
        //セグメントビューの左
        let segmentLeftBtn = UIButton()
        segmentLeftBtn.frame = CGRect(x: viewWidth*0.03, y: segmentViewHeight*0.1, width: viewWidth*0.3, height: segmentViewHeight*0.7)
        segmentLeftBtn.setTitle("すべて", for: UIControlState.normal)
        segmentLeftBtn.setTitleColor(UIColor.segmetRightBlue(), for: UIControlState.normal)
        //segmentLeftBtn.backgroundColor = UIColor.blue
        segmentView.addSubview(segmentLeftBtn)
        
        //セグメントビューの真ん中
        let segmentCenterBtn = UIButton()
        segmentCenterBtn.frame = CGRect(x: viewWidth*0.36, y: segmentViewHeight*0.1, width: viewWidth*0.3, height: segmentViewHeight*0.7)
        segmentCenterBtn.setTitle("ユーザー", for: UIControlState.normal)
        segmentCenterBtn.setTitleColor(UIColor.segmetRightBlue(), for: UIControlState.normal)
        segmentView.addSubview(segmentCenterBtn)
        
        //セグメントビューの右
        let segmentRightBtn = UIButton()
        segmentRightBtn.frame = CGRect(x: viewWidth*0.69, y: segmentViewHeight*0.1, width: viewWidth*0.3, height: segmentViewHeight*0.7)
        segmentRightBtn.setTitle("タグ", for: UIControlState.normal)
        segmentRightBtn.setTitleColor(UIColor.segmetRightBlue(), for: UIControlState.normal)
        //segmentRightBtn.backgroundColor = UIColor.blue
        segmentView.addSubview(segmentRightBtn)
        
        //下線
        let leftUnderBar = UIView()
        leftUnderBar.frame = CGRect(x: viewWidth*0.05, y: segmentViewHeight*0.1, width: viewWidth*0.4, height: segmentViewHeight*0.7)
        leftUnderBar.backgroundColor = UIColor.segmetRightBlue()
    }
    
    //左側のボタンが押されたら呼ばれる
    internal func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
    }

}
