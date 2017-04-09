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
    
    private var detailScrollView: UIScrollView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        
        //各部品の高さを取得
        statusHeight = UIApplication.shared.statusBarFrame.height
        navBarHeight =  self.navigationController?.navigationBar.frame.height
        scrollViewHeight = viewHeight-(statusHeight+navBarHeight)
        
        
        setView()
        
        setScrollView()
    }
    
    //Viewへの配置
    func setView() {
        
        //背景色を変更
        self.view.backgroundColor = UIColor.mainAppColor()
        
        // MARK: - UINavigationBar
        //myNavBar = UINavigationBar()
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: statusHeight, width: viewWidth, height: navBarHeight)
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        
        //ハイライトを消す
        self.navigationController?.navigationBar.isTranslucent = false
        
    
        //ナビゲーションボタンの色を変更する
        UINavigationBar.appearance().tintColor = UIColor.white
        
    }
    
    //スクロールビューの生成
    func setScrollView(){
        
        // ScrollViewを生成.
        detailScrollView = UIScrollView()
        detailScrollView.delegate = self
        detailScrollView.frame = CGRect(x: 0, y:0, width: viewWidth, height: scrollViewHeight)
        detailScrollView.backgroundColor = UIColor.white
        detailScrollView.contentSize = CGSize(width:viewWidth, height:viewHeight*2)
        self.view.addSubview(detailScrollView)
        
        
        //一つ目
        let postDetails = PostDetailView(viewWidth: viewWidth,viewHeight: viewHeight)
        postDetails.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth*1.6)
        postDetails.backgroundColor = UIColor.white
        detailScrollView.addSubview(postDetails)

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
