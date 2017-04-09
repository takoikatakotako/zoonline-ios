//
//  PictureDetailViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PictureDetailViewController: UIViewController,UIScrollViewDelegate {

    
    //width, height
    private var statusHeight:CGFloat!
    private var navBarHeight:CGFloat!
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var scrollViewHeight:CGFloat!
    
    //view parts
    private var myNavBar:UINavigationBar!
    
    private var detailScrollView: UIScrollView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        
        //各部品の高さを取得
        statusHeight = UIApplication.shared.statusBarFrame.height
        navBarHeight =  40
        scrollViewHeight = viewHeight-(statusHeight+navBarHeight)
        
        setView()
        
        setScrollView()
        
    }
    
    //Viewへの配置
    func setView() {
        
        //背景色を変更
        self.view.backgroundColor = UIColor.mainAppColor()
        
        // MARK: - UINavigationBar
        myNavBar = UINavigationBar()
        myNavBar.frame = CGRect(x: 0, y: statusHeight, width: viewWidth, height: navBarHeight)
        myNavBar.barTintColor = UIColor.mainAppColor()
        
        //ハイライトを消す
        myNavBar.isTranslucent = false
        
        //ナビゲーションボタンの色を変更する
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let myNavItems = UINavigationItem()
        
        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(barButtonSystemItem:  .stop, target: self, action: #selector(leftBarBtnClicked(sender:)))
        myNavItems.leftBarButtonItem = leftNavBtn
        
        //作成したNavItemをNavBarに追加する
        myNavBar.pushItem(myNavItems, animated: true)
        self.view.addSubview(myNavBar)
    }
    
    //スクロールビューの生成
    func setScrollView(){
        
        // ScrollViewを生成.
        detailScrollView = UIScrollView()
        detailScrollView.delegate = self
        detailScrollView.frame = CGRect(x: 0, y: statusHeight+navBarHeight!, width: viewWidth, height: scrollViewHeight)
        detailScrollView.backgroundColor = UIColor.white
        self.view.addSubview(detailScrollView)
        
        
        let sampleImg:UIImage = UIImage(named: "sample_detail")!
        let sampleImgView = UIImageView()
        sampleImgView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: scrollViewHeight)
        sampleImgView.image = sampleImg
        detailScrollView.addSubview(sampleImgView)

    }

    

    //左側のボタンが押されたら呼ばれる
    func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
        self.dismiss(animated: true, completion: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
