//
//  EditUserProfileVC.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/09/10.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView

class EditUserProfileVC: UIViewController {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    
    private var userProfileTexView:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        
        self.view.backgroundColor = UIColor.white
        
        setNavigationBar()
        
        // 名前
        let nameLabel:UILabel = UILabel()
        nameLabel.frame = CGRect(x: viewWidth*0.05, y:  viewHeight*0.05, width: viewWidth*0.9, height:24)
        nameLabel.text = "プロフィールを変更します"
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(nameLabel)
        
        //ユーザー名入力欄
        userProfileTexView = UITextView()
        userProfileTexView.textAlignment = NSTextAlignment.left
        userProfileTexView.frame = CGRect(x: viewWidth*0.05, y: viewHeight*0.13, width: viewWidth*0.9, height: viewWidth*0.2)
        userProfileTexView.textColor = UIColor.gray
        self.view.addSubview(userProfileTexView)
        
        let myProfile = UtilityLibrary.getUserProfile()
        if myProfile.isEmpty {
            userProfileTexView.text = "あなたのプロフィールを記入してください。"
        }else{
            userProfileTexView.text = myProfile
        }
        
        //userNameTextFIeldUnderLine
        let userNameTextFIeldLine:UIView = UIView()
        userNameTextFIeldLine.frame = CGRect(x: viewWidth*0.05, y: viewHeight*0.25, width: viewWidth*0.9, height: 1)
        userNameTextFIeldLine.backgroundColor = UIColor.gray
        self.view.addSubview(userNameTextFIeldLine)
        
        //LoginButton
        let changeUserNameBtn:UIButton = UIButton()
        changeUserNameBtn.frame = CGRect(x: viewWidth*0.1, y: viewHeight*0.3, width: viewWidth*0.8, height: viewWidth*0.15)
        changeUserNameBtn.backgroundColor = UIColor.mainAppColor()
        changeUserNameBtn.setTitle("変更を保存", for: UIControlState.normal)
        changeUserNameBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        changeUserNameBtn.layer.masksToBounds = true
        changeUserNameBtn.layer.cornerRadius = 4.0
        changeUserNameBtn.addTarget(self, action: #selector(changeUserProfileBtn(sender:)), for: .touchUpInside)
        self.view.addSubview(changeUserNameBtn)
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "プロフィールの変更"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }
    
    func changeUserProfileBtn(sender: UIButton){
        
        if (userProfileTexView.text?.isEmpty)! {
            SCLAlertView().showInfo("エラー", subTitle: "ユーザー名の入力が必要です。")
            return
        }
        
        let parameters: Parameters = [
            "profile":"おっぱいいっぱいゆめいっぱい"
        ]
        
        Alamofire.request(API_URL+"v0/users/"+UtilityLibrary.getUserID(), method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON{response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)

                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
