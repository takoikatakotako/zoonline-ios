//
//  ZooTabBarController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class ZooTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // アイコンの色
        UITabBar.appearance().tintColor = UIColor.tabIconSelected()
        UITabBar.appearance().unselectedItemTintColor = UIColor.tabNonIconSelected()
        
        // 背景色
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().isTranslucent = false
        
    }
}
