//
//  PostViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    //テーブルビューインスタンス
    private var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        let viewWidth = self.view.frame.size.width
        let viewHeight = self.view.frame.size.height
        
        let samplePostView:UIImageView = UIImageView()
        samplePostView.image = UIImage(named: "post_sample")
        samplePostView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        self.view.addSubview(samplePostView)
    }

}
