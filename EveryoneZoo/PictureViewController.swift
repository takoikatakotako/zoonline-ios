//
//  PictureViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/17.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import SCLAlertView


class PictureViewController: UIViewController,UIScrollViewDelegate {
    
    //width, height
    private var statusHeight:CGFloat!
    private var navBarHeight:CGFloat!
    private var segmentViewHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var scrollViewHeight:CGFloat!
    
    //view parts
    private var segmentView:UIView!
    private var pictureScrollView: UIScrollView!
    
    
    @IBOutlet weak var serchNavBtn: UIBarButtonItem!
    
    //imageViews
    var imageViewAry:Array<UIButton> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        
        //各部品の高さを取得
        statusHeight = UIApplication.shared.statusBarFrame.height
        navBarHeight =  self.navigationController?.navigationBar.frame.height
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
        self.view.backgroundColor = UIColor.mainAppColor()
        
        //ステータスバー部分の背景
        let statusBackColor = UIView()
        statusBackColor.frame = CGRect(x: 0, y: -(statusHeight+navBarHeight), width: viewWidth, height: navBarHeight*2)
        statusBackColor.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusBackColor)
        
        // MARK: - UINavigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        
        //ハイライトを消す
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションボタンの色を変更する
        UINavigationBar.appearance().tintColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = "ひろば"

        serchNavBtn.tintColor = UIColor.white
        serchNavBtn.action = #selector(rightBarBtnClicked(sender:))
    }
    
    //セグメントビューの生成
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
    
            let pictureImageBtn:UIButton = UIButton()
            pictureImageBtn.layer.cornerRadius = 30
            pictureImageBtn.clipsToBounds = true
            
            if ((i/6)%2 == 0){
                
                switch i%6 {
                case 0:
                    pictureImageBtn.frame = CGRect(x: 0, y: scrollYPos, width: picImageWidth*2, height: picImageWidth*2)
                    break
                case 1:
                    pictureImageBtn.frame = CGRect(x: picImageWidth*2, y: scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                case 2:
                    pictureImageBtn.frame = CGRect(x: picImageWidth*2, y: picImageWidth+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                case 3:
                    pictureImageBtn.frame = CGRect(x: 0, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                case 4:
                    pictureImageBtn.frame = CGRect(x: picImageWidth, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                case 5:
                    pictureImageBtn.frame = CGRect(x: picImageWidth*2, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                default:
                    break
                }
            }else{
                
                switch i%6 {
                case 0:
                    pictureImageBtn.frame = CGRect(x: 0, y: scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                case 1:
                    pictureImageBtn.frame = CGRect(x: 0, y: picImageWidth+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                case 2:
                    pictureImageBtn.frame = CGRect(x: picImageWidth, y: scrollYPos, width: picImageWidth*2, height: picImageWidth*2)
                    break
                    
                case 3:
                    pictureImageBtn.frame = CGRect(x: 0, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                    
                case 4:
                    pictureImageBtn.frame = CGRect(x: picImageWidth, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                    
                case 5:
                    pictureImageBtn.frame = CGRect(x: picImageWidth*2, y: picImageWidth*2+scrollYPos, width: picImageWidth, height: picImageWidth)
                    break
                default:
                    break
                }

            }
            pictureImageBtn.setBackgroundImage(myImage, for: UIControlState.normal)
            pictureImageBtn.addTarget(self, action: #selector(pictureSelected(sender:)), for:.touchUpInside)
            imageViewAry.append(pictureImageBtn)
            
            
            for imgView in imageViewAry{
                pictureScrollView.addSubview(imgView)
            }
        }
        
        // ScrollViewの大きさを設定する.
        pictureScrollView.frame = CGRect(x: 0, y: segmentViewHeight!, width: viewWidth, height: scrollViewHeight)
        
        // Scrollの高さを計算しておく.
        let scroll_height = viewWidth*CGFloat((imageCount/6))+picImageWidth
        
        // ScrollViewにcontentSizeを設定する.
        pictureScrollView.contentSize = CGSize(width:viewWidth, height:scroll_height)
        
        pictureScrollView.backgroundColor = UIColor.white
        
        // ViewにScrollViewをAddする.
        self.view.addSubview(pictureScrollView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: .valueChanged)
        pictureScrollView.refreshControl = refreshControl
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
                self.pictureScrollView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight)

            }
        }else{
            animator.addAnimations {
                // animation
                self.navigationController?.navigationBar.frame = CGRect(x: 0, y: self.statusHeight, width: self.viewWidth, height: self.navBarHeight)
                self.segmentView.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.segmentViewHeight)
                self.pictureScrollView.frame = CGRect(x: 0, y: self.segmentViewHeight!, width: self.viewWidth, height: self.scrollViewHeight)

            }
        }
        
        animator.startAnimation()
    }
    
    
    //左側のボタンが押されたら呼ばれる
    internal func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
    }
    
    
    func scrollReflesh(sender : UIRefreshControl) {
        
        SCLAlertView().showInfo("スクロールイベントが実行された", subTitle: "close")
        sender.endRefreshing()
    }
    
    //
    internal func pictureSelected(sender: UIButton){
        
        // 遷移するViewを定義する.

        let second = PictureDetailViewController()
        navigationController?.pushViewController(second as UIViewController, animated: true)
    }
    
    internal func rightBarBtnClicked(sender: UIButton){
        print("rightBarBtnClicked")

    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
