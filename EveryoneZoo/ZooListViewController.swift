//
//  ZooListViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/03/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import PageMenu

class ZooListViewController: UIViewController,SampleDelegate {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    
    
    var pageMenu : CAPSPageMenu?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        

        self.view.backgroundColor = UIColor.gray
        //setNavigationBar()
        
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        // Example:
        let controller : NewsListViewController = NewsListViewController()
        controller.title = "ニュース"
        controller.delegate = self
        controllerArray.append(controller)
        
        
        let controller2 : OfficialListViewController = OfficialListViewController()
        controller2.title = "オフィシャル"
        controllerArray.append(controller2)
        
        

        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.gray),
            .viewBackgroundColor(UIColor.gray),
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .bottomMenuHairlineColor(UIColor.blue),
            .selectionIndicatorColor(UIColor.red),
                .selectedMenuItemLabelColor(UIColor.black),
            .unselectedMenuItemLabelColor(UIColor.green)
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR, width: self.view.frame.width, height: self.view.frame.height-(PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR)), pageMenuOptions: parameters)
        

        
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.view.addSubview(pageMenu!.view)
        
    }
    // MARK: - Viewにパーツの設置
    
    // MARK: ステータスバー背景
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel(frame: CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR))
        titleLabel.text = "オフィシャル"
        self.navigationItem.titleView = titleLabel
    }

    
    //Delegateで呼ぶViewの背景色を変えるメソッド
    func changeBackgroundColor(color:UIColor){
        
        print(color)
        

 let contactView:WebViewController = WebViewController()
 contactView.url = CONTACT_PAGE_URL_STRING
 contactView.navTitle = "お問い合わせ"
 self.present(contactView, animated: true, completion: nil)
    }
}
