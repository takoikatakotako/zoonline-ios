//
//  ZooListViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import PageMenu

class ZooListViewController: UIViewController,NewsDelegate,CAPSPageMenuDelegate {
    
    //width, height
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    var statusBarHeight:CGFloat!
    var navigationBarHeight:CGFloat!
    var pageMenuHeight:CGFloat!
    var tabBarHeight:CGFloat!
    private var contentsViewHeight:CGFloat!
    
    var pageMenu : CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let controller : NewsListViewController = NewsListViewController()
        controller.title = "ニュース"
        controller.delegate = self
        controller.statusBarHeight = statusBarHeight
        controller.navigationBarHeight = navigationBarHeight
        controller.tabBarHeight = tabBarHeight
        controller.pageMenuHeight = pageMenuHeight
        controllerArray.append(controller)
        
        let controller2 : OfficialListViewController = OfficialListViewController()
        controller2.title = "編集部便り"
        controllerArray.append(controller2)
        
        
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
    
    func willMoveToPage(_ controller: UIViewController, index: Int){
    
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int){}
    
    
    
    // MARK: - Viewにパーツの設置
    func setNavigationBar() {
        
        //ステータスバー部分の覆い
        let statusBgView:UIView = UIView()
        statusBgView.frame = CGRect(x: 0, y: -navigationBarHeight*2, width: viewWidth, height: navigationBarHeight*2)
        statusBgView.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusBgView)
        
        //ナビゲーションコントローラーの色の変更
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "オフィシャル"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
    }
    
    //Delegateで呼ぶViewの背景色を変えるメソッド
    func openNews(newsUrl:String){
        //ここでニュースページに飛ぶ
        let url = URL(string:newsUrl)
        if( UIApplication.shared.canOpenURL(url!) ) {
            UIApplication.shared.open(url!)
        }
    }
}
