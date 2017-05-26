//
//  UserInfoViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/26.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    //width, height
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    
    //UserInfo
    var postUserID:Int!
    var postUserName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
    
        self.view.backgroundColor = UIColor.red
        setNavigationBar()
        
        
        let profileSample:UIImageView = UIImageView()
        profileSample.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth)
        profileSample.image = UIImage(named:"sample_profile")
        self.view.addSubview(profileSample)
    }
    
    // MARK: NavigationBar
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = self.postUserName
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }


}
