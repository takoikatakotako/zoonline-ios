//
//  PictureViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/17.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import PageMenu

class FieldViewController: UIViewController,CAPSPageMenuDelegate {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var pageMenuHeight:CGFloat!
    private var contentsViewHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        let statusBarHeight:CGFloat = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        pageMenuHeight = navigationBarHeight
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        contentsViewHeight = viewHeight
        print(contentsViewHeight)
        setNavigationBar()
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        let NewPostsVC : NewPostsViewController = NewPostsViewController()
        NewPostsVC.title = "人気"
        NewPostsVC.statusBarHeight = statusBarHeight
        NewPostsVC.navigationBarHeight = navigationBarHeight
        NewPostsVC.pageMenuHeight = pageMenuHeight
        NewPostsVC.tabBarHeight = tabBarHeight
        controllerArray.append(NewPostsVC)
        
        let PopularPostVC : PopularPostViewController = PopularPostViewController()
        PopularPostVC.title = "新着"
        PopularPostVC.statusBarHeight = statusBarHeight
        PopularPostVC.navigationBarHeight = navigationBarHeight
        PopularPostVC.pageMenuHeight = pageMenuHeight
        PopularPostVC.tabBarHeight = tabBarHeight
        controllerArray.append(PopularPostVC)
        
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.white),
            .menuItemSeparatorWidth(4),
            .menuHeight(pageMenuHeight),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .bottomMenuHairlineColor(UIColor.blue),
            .selectionIndicatorColor(UIColor.segmetRightBlue()),
            .selectedMenuItemLabelColor(UIColor.mainAppColor()),
            .menuItemFont(UIFont.boldSystemFont(ofSize: 16)),
            .unselectedMenuItemLabelColor(UIColor.gray)
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 0, width: viewWidth, height: contentsViewHeight), pageMenuOptions: parameters)
        pageMenu!.view.backgroundColor = UIColor.white
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)
    }
    
    
    // MARK: - Viewにパーツの設置
    func setNavigationBar() {
        
        //ステータスバー部分の覆い
        let statusBgView:UIView = UIView()
        statusBgView.frame = CGRect(x: 0, y: -PARTS_HEIGHT_NAVIGATION_BAR*2, width: viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR*2)
        statusBgView.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusBgView)
        
        //ナビゲーションコントローラーの色の変更
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "ひろば"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
    }
}
