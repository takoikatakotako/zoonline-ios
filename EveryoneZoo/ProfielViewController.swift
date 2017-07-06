//
//  ProfielViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/07.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class ProfielViewController: UIViewController {
    
    //width,height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var loginViewHeight:CGFloat!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        
        self.view.backgroundColor = UIColor.white

    }
}
