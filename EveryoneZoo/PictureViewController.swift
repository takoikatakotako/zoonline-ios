//
//  PictureViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/17.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit


class PictureViewController: UIViewController,UIScrollViewDelegate {
    
    //width, height
    var statusHeight:CGFloat!
    var navBarHeight:CGFloat!
    var segmentViewHeight:CGFloat!
    var tabBarHeight:CGFloat!
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    var scrollViewHeight:CGFloat!
    
    //view parts
    var myNavBar:UINavigationBar!
    var segmentView:UIView!
    var pictureScrollView: UIScrollView!
    
    //imageViews
    var imageViewAry:Array<UIImageView> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        
        //各部品の高さを取得
        statusHeight = UIApplication.shared.statusBarFrame.height
        navBarHeight =  40
        segmentViewHeight = 40
        tabBarHeight = UITabBar.appearance().frame.size.height
        scrollViewHeight = viewHeight-(statusHeight+navBarHeight+segmentViewHeight+tabBarHeight+tabBarHeight)
        
        
        setView()
        
        setSegmentView()
        
        setScrollView()
        
    }
    
    //Viewへの配置
    func setView() {
        
        //背景色を変更
        self.view.backgroundColor = UtilityLibrary.getZooThemeColor()
        
        // MARK: - UINavigationBar
        myNavBar = UINavigationBar()
        myNavBar.frame = CGRect(x: 0, y: statusHeight, width: viewWidth, height: navBarHeight)
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
    
    //セグメントビューの生成
    func setSegmentView(){
        
        // MARK: - segmentView
        segmentView = UIView()
        segmentView.frame = CGRect(x: 0, y: statusHeight+navBarHeight, width: viewWidth, height: segmentViewHeight)
        segmentView.backgroundColor = UIColor.white
        self.view.addSubview(segmentView)
        
        //スクロールビューとの区切り線
        let segmentLine = UIView()
        segmentLine.frame = CGRect(x: 0, y: segmentViewHeight - 2, width: viewWidth, height: 2)
        segmentLine.backgroundColor = UIColor.gray
        segmentView.addSubview(segmentLine)
        
        //セグメントビューの左
        let segmentLeftBtn = UIButton()
        segmentLeftBtn.frame = CGRect(x: viewWidth*0.05, y: segmentViewHeight*0.1, width: viewWidth*0.4, height: segmentViewHeight*0.7)
        segmentLeftBtn.setTitle("人気", for: UIControlState.normal)
        segmentLeftBtn.setTitleColor(UIColor.segmetRightBlue(), for: UIControlState.normal)
        //segmentLeftBtn.backgroundColor = UIColor.blue
        segmentView.addSubview(segmentLeftBtn)
        
        //下線
        let leftUnderBar = UIView()
        leftUnderBar.frame = CGRect(x: viewWidth*0.05, y: segmentViewHeight*0.1, width: viewWidth*0.4, height: segmentViewHeight*0.7)
        leftUnderBar.backgroundColor = UIColor.segmetRightBlue()
        
        //セグメントビューの右
        let segmentRightBtn = UIButton()
        segmentRightBtn.frame = CGRect(x: viewWidth*0.55, y: segmentViewHeight*0.1, width: viewWidth*0.4, height: segmentViewHeight*0.7)
        segmentRightBtn.setTitle("新着", for: UIControlState.normal)
        segmentRightBtn.setTitleColor(UIColor.segmetRightBlue(), for: UIControlState.normal)
        //segmentRightBtn.backgroundColor = UIColor.blue
        segmentView.addSubview(segmentRightBtn)
    
    }
    
    
    
    //スクロールビューの生成
    func setScrollView(){
        
        // ScrollViewを生成.
        pictureScrollView = UIScrollView()
        self.pictureScrollView.delegate = self
        
        //一つあたりの画像サイズ
        let picImageWidth = viewWidth/3.0

        //設定画像
        let myImage: UIImage = UIImage(named: "sample_kabi1")!

        //表示数
        let imageCount:NSInteger = 24
        
        for i in 0..<imageCount {
        
            let scrollYPos:CGFloat! = viewWidth*CGFloat(i/6)
    
            let pictureImageView:UIImageView = UIImageView()
            pictureImageView.image = myImage
            pictureImageView.layer.cornerRadius = 30
            pictureImageView.clipsToBounds = true
            
            if ((i/6)%2 == 0){
                
                switch i%6 {
                case 0:
                    pictureImageView.frame = CGRect(x: 0, y: scrollYPos, width: picImageWidth*2, height: picImageWidth*2)
                    break
                case 1:
                    
                    pictureImageView.frame = CGRect(x: picImageWidth*2, y: scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                    
                case 2:
                    pictureImageView.frame = CGRect(x: picImageWidth*2, y: picImageWidth+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                    
                case 3:
                    pictureImageView.frame = CGRect(x: 0, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                    
                case 4:
                    pictureImageView.frame = CGRect(x: picImageWidth, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                    
                case 5:
                    pictureImageView.frame = CGRect(x: picImageWidth*2, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                default:
                    break
                }
            }else{
                
                switch i%6 {
                case 0:
                    pictureImageView.frame = CGRect(x: 0, y: scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                case 1:
                    pictureImageView.frame = CGRect(x: 0, y: picImageWidth+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                case 2:
                    pictureImageView.frame = CGRect(x: picImageWidth, y: scrollYPos, width: picImageWidth*2, height: picImageWidth*2)
                    break
                    
                case 3:
                    pictureImageView.frame = CGRect(x: 0, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                    
                case 4:
                    pictureImageView.frame = CGRect(x: picImageWidth, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                    
                case 5:
                    pictureImageView.frame = CGRect(x: picImageWidth*2, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                default:
                    break
                }

            }
            
            imageViewAry.append(pictureImageView)
            
            
            for imgView in imageViewAry{
                pictureScrollView.addSubview(imgView)
            }
        }
        
        // ScrollViewの大きさを設定する.
        pictureScrollView.frame = CGRect(x: 0, y: statusHeight+navBarHeight+segmentViewHeight!, width: viewWidth, height: scrollViewHeight)
        
        // Scrollの高さを計算しておく.
        let scroll_height = viewWidth*CGFloat((imageCount/6))+picImageWidth
        
        // ScrollViewにcontentSizeを設定する.
        pictureScrollView.contentSize = CGSize(width:viewWidth, height:scroll_height)
        
        pictureScrollView.backgroundColor = UIColor.white
        
        // ViewにScrollViewをAddする.
        self.view.addSubview(pictureScrollView)
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
                self.myNavBar.frame = CGRect(x: 0, y: -(self.statusHeight+self.navBarHeight), width: self.viewWidth, height: self.navBarHeight)
                self.segmentView.frame = CGRect(x: 0, y: self.statusHeight, width: self.viewWidth, height: self.segmentViewHeight)
                self.pictureScrollView.frame = CGRect(x: 0, y: self.statusHeight+self.segmentViewHeight, width: self.viewWidth, height: self.viewHeight)

            }
        }else{
            animator.addAnimations {
                // animation
                self.myNavBar.frame = CGRect(x: 0, y: self.statusHeight, width: self.viewWidth, height: self.navBarHeight)
                self.segmentView.frame = CGRect(x: 0, y: self.statusHeight+self.navBarHeight, width: self.viewWidth, height: self.segmentViewHeight)
                self.pictureScrollView.frame = CGRect(x: 0, y: self.statusHeight+self.navBarHeight+self.segmentViewHeight!, width: self.viewWidth, height: self.scrollViewHeight)

            }
        }
        
        animator.startAnimation()
    }
    
    
    //左側のボタンが押されたら呼ばれる
    internal func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
