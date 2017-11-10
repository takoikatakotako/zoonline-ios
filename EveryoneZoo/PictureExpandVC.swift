//
//  PictureExpandVC.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/11/10.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PictureExpandVC: UIViewController {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var scrollViewHeight:CGFloat!

    var statusBarHeight:CGFloat!
    var navigationBarHeight:CGFloat!
    var image:UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        scrollViewHeight = viewHeight - (statusBarHeight+navigationBarHeight)
        
        self.view.backgroundColor = UIColor.red
        
        
        setNavigationBar()

        let postImgView = UIImageView()
        postImgView.frame = CGRect(x: 0, y: statusBarHeight+navigationBarHeight, width: self.view.frame.width, height: scrollViewHeight)
        postImgView.image = self.image
        postImgView.backgroundColor = UIColor.white
        postImgView.contentMode = UIViewContentMode.scaleAspectFit
        postImgView.isUserInteractionEnabled = true
        self.view.addSubview(postImgView)
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        //ステータスバー部分の覆い
        let aadView:UIView = UIView()
        aadView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: statusBarHeight*2)
        aadView.backgroundColor = UIColor.MainAppColor()
        self.view.addSubview(aadView)
        
        //ナビゲーションコントローラーの色の変更
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: statusBarHeight, width: viewWidth, height: navigationBarHeight)
        navBar.barTintColor = UIColor.MainAppColor()
        navBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let navItems = UINavigationItem()
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "oppai"
        titleLabel.textColor = UIColor.white
        navItems.titleView = titleLabel
        navBar.pushItem(navItems, animated: true)
        
        
        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(doClose(sender:)))
        navItems.leftBarButtonItem = leftNavBtn
        self.view.addSubview(navBar)
    }
    
    func doClose(sender: UIButton){
        
        self.dismiss(animated: true, completion: nil)
    }
}
