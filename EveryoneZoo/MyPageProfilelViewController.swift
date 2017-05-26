//
//  MyPageProfilelViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/18.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class MyPageProfilelViewController: UIViewController {

    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height

        setNavigationBar()
        
        self.view.backgroundColor = UIColor.white

        
        
        let profileSample:UIImageView = UIImageView()
        profileSample.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth)
        profileSample.image = UIImage(named:"sample_profile")
        self.view.addSubview(profileSample)
        
    }

    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "プロフィール"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }

}
