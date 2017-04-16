//
//  TimeLineViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import SCLAlertView

class TimeLineViewController: UIViewController,UIScrollViewDelegate {
    
    private var statusHeight:CGFloat!
    private var navBarHeight:CGFloat!
    private var segmentViewHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    var scrollViewHeight:CGFloat!
    
    //view parts
    private var segmentView:UIView!
    var timelineScrollView: UIScrollView!

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

        setScrollView()
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
        
        //ステータスバー部分の背景
        let statusBackColor = UIView()
        statusBackColor.frame = CGRect(x: 0, y: -(statusHeight+navBarHeight), width: viewWidth, height: navBarHeight*2)
        statusBackColor.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusBackColor)

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
    
    
    //スクロールビューの生成
    func setScrollView(){
        
        // ScrollViewを生成.
        timelineScrollView = UIScrollView()
        self.timelineScrollView.delegate = self

        
        // ScrollViewの大きさを設定する.
        timelineScrollView.frame = CGRect(x: 0, y: segmentViewHeight!, width: viewWidth, height: scrollViewHeight)
        
        // Scrollの高さを計算しておく.
        // ScrollViewにcontentSizeを設定する.
        timelineScrollView.contentSize = CGSize(width:viewWidth, height:viewHeight*4)
        
        timelineScrollView.backgroundColor = UIColor.white
        
        // ViewにScrollViewをAddする.
        self.view.addSubview(timelineScrollView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: .valueChanged)
        timelineScrollView.refreshControl = refreshControl
        
        
        //
        let myBun = UIButton()
        myBun.addTarget(self, action: #selector(testButtonClicked(sender:)), for:.touchUpInside)
        
        //一つ目
        let postDetails = PostDetailView(viewWidth: viewWidth,viewHeight: viewHeight)
        postDetails.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth*1.6)
        postDetails.backgroundColor = UIColor.white
        timelineScrollView.addSubview(postDetails)
        
        //2つ目
        let postDetails2 = PostDetailView(viewWidth: viewWidth,viewHeight: viewHeight)
        postDetails2.frame = CGRect(x: 0, y: viewWidth*1.7, width: viewWidth, height: viewWidth*1.6)
        postDetails2.backgroundColor = UIColor.white
        timelineScrollView.addSubview(postDetails2)
        
        //3つ目
        let postDetails3 = PostDetailView(viewWidth: viewWidth,viewHeight: viewHeight)
        postDetails3.frame = CGRect(x: 0, y: viewWidth*3.4, width: viewWidth, height: viewWidth*1.6)
        postDetails3.backgroundColor = UIColor.white
        timelineScrollView.addSubview(postDetails3)
    
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        
        
        if (velocity.y > 0) {
            // 上下のバーを隠す
            print("上")
            
            hidesBarsWithScrollView(hidden: true, hiddenTop: true, hiddenBottom: true)
            
            // 上下のバーを表示する
        } else {
            // 上下のバーを表示する
            print("した")
            hidesBarsWithScrollView(hidden: false, hiddenTop: true, hiddenBottom: true)
        }
    }
    
    
    func hidesBarsWithScrollView( hidden:Bool, hiddenTop:Bool, hiddenBottom:Bool) {
        
        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: 0.2, timingParameters: timing)
        
        
        if hidden {
            animator.addAnimations {
                // animation
                self.navigationController?.navigationBar.frame = CGRect(x: 0, y: -self.navBarHeight, width: self.viewWidth, height: self.navBarHeight)
                self.segmentView.frame = CGRect(x: 0, y: -self.segmentViewHeight, width: self.viewWidth, height: self.segmentViewHeight)
                self.timelineScrollView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight)
                
            }
        }else{
            animator.addAnimations {
                // animation
                self.navigationController?.navigationBar.frame = CGRect(x: 0, y: self.statusHeight, width: self.viewWidth, height: self.navBarHeight)
                self.segmentView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.segmentViewHeight)
                self.timelineScrollView.frame = CGRect(x: 0, y: self.segmentViewHeight!, width: self.viewWidth, height: self.scrollViewHeight)
                
            }
        }
        
        animator.startAnimation()
    }
    
    
    func testButtonClicked(sender: UIButton) {
        
        
    }
    
    
    func scrollReflesh(sender : UIRefreshControl) {
        
        SCLAlertView().showInfo("スクロールイベントが実行された", subTitle: "close")
        sender.endRefreshing()
    }
    
    //左側のボタンが押されたら呼ばれる
    internal func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
    }

}