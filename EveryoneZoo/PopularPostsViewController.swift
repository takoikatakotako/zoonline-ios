//
//  PopularPostViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/13.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import SwiftyJSON
import SDWebImage

protocol PopularPostsDelegate: class  {
    func goDetailView(postID:Int)
    func startIndicator()
    func stopIndicator()
}

class PopularPostsViewController: CustumViewController{
    //delegate
    weak var delegate: PopularPostsDelegate?
    
    //width, height
    var pageMenuHeight:CGFloat!
    private var tableViewHeight:CGFloat!

    //APIから取得したデーター
    var imageURLs:Array<String> = Array()
    var postIds:Array<Int> = Array()
    var isNetWorkConnect:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //画面横サイズを取得
        self.viewWidth = self.view.frame.width
        self.viewHeight = self.view.frame.height

        delegate?.startIndicator()
        //network
    }
    
    // タッチイベントの検出
    //MARK: シングルタップ時に実行される
    @objc func tapSingle(sender: UITapGestureRecognizer) {
        print(sender.view?.tag ?? 400)
        
        delegate?.goDetailView(postID: sender.view?.tag ?? 400)
    }
    
    @objc func scrollReflesh(sender : UIRefreshControl) {
        
        //network
        delegate?.startIndicator()
    }
}
