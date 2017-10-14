//
//  WritePostsCommentsViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/30.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView

class WritePostsCommentsViewController: UIViewController {
    
    var postsID:Int!
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    var textViewHeight:CGFloat!

    //テーブルビューインスタンス
    private var commentTextView: UITextView!
    
    //Indicater
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        textViewHeight = viewHeight - (statusBarHeight + navigationBarHeight + tabBarHeight)
        self.view.backgroundColor = UIColor.white
        
        setNavigationBar()
        
        setTextView()
        
        setActivityIndicator()
    }
    
    
    // MARK: - Viewにパーツの設置
    // MARK: NavigationBar
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.MainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "コメント"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        
        //バーの右側に設置するボタンの作成
        let rightNavBtn = UIBarButtonItem()
        rightNavBtn.image = UIImage(named:"submit_nav_btn")!
        rightNavBtn.action = #selector(postNavBtnClicked(sender:))
        rightNavBtn.target = self
        self.navigationItem.rightBarButtonItem = rightNavBtn
    }
    
    func setTextView(){
        
        // TextView生成する.
        commentTextView = UITextView()
        commentTextView.frame = CGRect(x:0, y:0, width:viewWidth, height:textViewHeight)
        commentTextView.text = ""
        commentTextView.font = UIFont.systemFont(ofSize: 20.0)
        commentTextView.textColor = UIColor.black
        self.view.addSubview(commentTextView)
        
        //キーボードは出しておく
        commentTextView.becomeFirstResponder()
    }
    
    // MARK: くるくるの生成
    func setActivityIndicator(){
        
        let indicaterSize:CGFloat = viewWidth*0.3
        indicator.frame = CGRect(x: (viewWidth-indicaterSize)/2, y: viewWidth*0.25, width: indicaterSize, height: indicaterSize)
        indicator.clipsToBounds = true
        indicator.layer.cornerRadius = indicaterSize*0.3
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = UIColor.MainAppColor()
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        indicator.color = UIColor.white
        self.view.bringSubview(toFront: indicator)
        self.view.addSubview(indicator)
    }
    
    // MARK: -
    func postNavBtnClicked(sender: UIButton){
        
        if commentTextView.text.isEmpty {
            SCLAlertView().showInfo("エラー", subTitle: "コメントの入力必要です。")
            return
        }
        
        //indicatrer
        indicator.startAnimating()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let myUserID:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUserID"))!
        
        let parameters: Parameters = [
            "post_id": String(postsID),
            "user_id": myUserID,
            "comments": commentTextView.text
        ]
        
        Alamofire.request(EveryZooAPI.getDoComments(), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                _ = self.navigationController?.popViewController(animated: true)
                
            case .failure(let error):
                print(error)
            }
            
            self.indicator.stopAnimating()
        }
    }
}
