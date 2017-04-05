//
//  PictureViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/17.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit


class PictureViewController: UIViewController,UIScrollViewDelegate {
    
    
    var statusHeight:CGFloat!
    var navBarHeight:CGFloat!
    var tabBarHeight:CGFloat!
    
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    
    var scrollViewHeight:CGFloat!
    
    
    var myNavBar:UINavigationBar!
    
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
        scrollViewHeight = viewHeight-(statusHeight+navBarHeight)
        
        setView()
        
        
    
        // ScrollViewを生成.
        pictureScrollView = UIScrollView()
        
        self.pictureScrollView.delegate = self
        
        // ScrollViewの大きさを設定する.
        pictureScrollView.frame = CGRect(x: 0, y: statusHeight+navBarHeight, width: viewWidth, height: scrollViewHeight)
        /*
        // UIImageに画像を設定する.
        let examplePic = UIImage(named: "example_pictures")!
        
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
        */
        // Scrollの高さを計算しておく.
        let scroll_height = viewHeight*2
        
        // ScrollViewにcontentSizeを設定する.
        pictureScrollView.contentSize = CGSize(width:viewWidth, height:scroll_height)

        pictureScrollView.backgroundColor = UIColor.red
        // ViewにScrollViewをAddする.
        self.view.addSubview(pictureScrollView)
 
    }
    
    //Viewへの配置
    func setView() {
        
        //背景色を変更
        self.view.backgroundColor = UtilityLibrary.getZooThemeColor()
        
        //UINavigationBarを作成
        myNavBar = UINavigationBar()
        
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
        
        print("上")

  
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
        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: timing)
        
        
        if hidden {
            animator.addAnimations {
                // animation
                self.myNavBar.frame = CGRect(x: 0, y: -(self.statusHeight+self.navBarHeight), width: self.viewWidth, height: self.navBarHeight)
                self.pictureScrollView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight)

            }
        }else{
            animator.addAnimations {
                // animation
                self.myNavBar.frame = CGRect(x: 0, y: self.statusHeight, width: self.viewWidth, height: self.navBarHeight)
                self.pictureScrollView.frame = CGRect(x: 0, y: self.statusHeight+self.navBarHeight, width: self.viewWidth, height: self.scrollViewHeight)

            }
        }
        
        
        
        animator.startAnimation()
        
        /*
        myNavBar.animateWithDuration(5, animations: { () -> Void in
            myNavBar.backgroundColor = UIColor.greenColor()
        })*/
    }
    
    
    //左側のボタンが押されたら呼ばれる
    internal func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
