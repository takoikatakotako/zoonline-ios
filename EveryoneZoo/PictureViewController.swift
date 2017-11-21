//
//  PictureViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/17.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import PageMenu

class FieldViewController: CustumViewController,CAPSPageMenuDelegate ,NewPostsDelegate, PopularPostsDelegate{
    
    //width, height
    private var pageMenuHeight:CGFloat!
    private var contentsViewHeight:CGFloat!
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        pageMenuHeight = navigationBarHeight
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        contentsViewHeight = viewHeight
        
        setNavigationBar()
        setPageMenu()
        self.showIndicater()
    }
    
    // MARK: - Viewにパーツの設置
    func setNavigationBar() {
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "ひろば"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
    }
    
    func setPageMenu() {
        
        var controllerArray : [UIViewController] = []
        
        let NewPostsVC : NewPostsViewController = NewPostsViewController()
        NewPostsVC.title = "新着"
        NewPostsVC.delegate = self
        NewPostsVC.statusBarHeight = statusBarHeight
        NewPostsVC.navigationBarHeight = navigationBarHeight
        NewPostsVC.pageMenuHeight = pageMenuHeight
        NewPostsVC.tabBarHeight = tabBarHeight
        controllerArray.append(NewPostsVC)
        
        let PopularPostsVC : PopularPostsViewController = PopularPostsViewController()
        PopularPostsVC.title = "人気"
        PopularPostsVC.delegate = self
        PopularPostsVC.statusBarHeight = statusBarHeight
        PopularPostsVC.navigationBarHeight = navigationBarHeight
        PopularPostsVC.pageMenuHeight = pageMenuHeight
        PopularPostsVC.tabBarHeight = tabBarHeight
        controllerArray.append(PopularPostsVC)
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.white),
            .menuItemSeparatorWidth(4),
            .menuHeight(pageMenuHeight),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .bottomMenuHairlineColor(UIColor.blue),
            .selectionIndicatorColor(UIColor.MainAppColor()),
            .selectedMenuItemLabelColor(UIColor.MainAppColor()),
            .menuItemFont(UIFont.boldSystemFont(ofSize: 16)),
            .unselectedMenuItemLabelColor(UIColor.gray)
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 0, width: viewWidth, height: contentsViewHeight), pageMenuOptions: parameters)
        pageMenu!.view.backgroundColor = UIColor.white
        pageMenu!.delegate = self
        self.view.addSubview(pageMenu!.view)
    }
    
    func goDetailView(postID:Int) {
        //画面遷移、投稿詳細画面へ
        let picDetailView: PictureDetailViewController = PictureDetailViewController()
        picDetailView.postID = postID
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }
    
    func startIndicator() {
        self.showIndicater()
    }
    
    func stopIndicator()  {
        self.hideIndicator()
    }

}
