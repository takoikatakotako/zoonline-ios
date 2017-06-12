//
//  LoginViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/12.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //width,height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var loginViewHeight:CGFloat!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        loginViewHeight = viewHeight - (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR)
        self.view.backgroundColor = UIColor.white
        
        //Viewにパーツを追加
        setNavigationBar()
        
        setView()
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        //ステータスバー部分の覆い
        let aadView:UIView = UIView()
        aadView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: PARTS_HEIGHT_STATUS_BAR*2)
        aadView.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(aadView)
        
        //ナビゲーションコントローラーの色の変更
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR, width: viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR)
        navBar.barTintColor = UIColor.mainAppColor()
        navBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let navItems = UINavigationItem()
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "ログイン"
        titleLabel.textColor = UIColor.white
        navItems.titleView = titleLabel
        
        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(title: "閉じる", style: .plain, target: self, action:  #selector(leftBarBtnClicked(sender:)))
        navItems.leftBarButtonItem = leftNavBtn
        
        navBar.pushItem(navItems, animated: true)
        self.view.addSubview(navBar)
    }
    
    // MARK: ナビゲーションバー
    func setView() {
        
        //Description
        let descriptionLabel:UILabel = UILabel()
        descriptionLabel.text = "投稿・タイムラインを利用する\nにはログインしてください"
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = NSTextAlignment.center
        descriptionLabel.frame = CGRect(x: viewWidth*0.1, y: (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR)+loginViewHeight*0.05, width: viewWidth*0.8, height: loginViewHeight*0.1)
        self.view.addSubview(descriptionLabel)
        
        //Login failed
        let loginFailed:UILabel = UILabel()
        loginFailed.text = "ログインできませんでした"
        loginFailed.textAlignment = NSTextAlignment.center
        loginFailed.frame = CGRect(x: viewWidth*0.1, y: (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR)+loginViewHeight*0.15, width: viewWidth*0.8, height: loginViewHeight*0.1)
        loginFailed.textColor = UIColor.LogInPinkColor()
        self.view.addSubview(loginFailed)
        
        //MailTest
        let mailTextField:UITextField = UITextField()
        mailTextField.frame = CGRect(x: viewWidth*0.1, y: (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR)+loginViewHeight*0.25, width: viewWidth*0.8, height: loginViewHeight*0.1)
        mailTextField.text = "ユーザー名またはメールアドレス"
        mailTextField.textColor = UIColor.gray
        mailTextField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(mailTextField)
    
        //MailTest
        let passWordTextField:UITextField = UITextField()
        passWordTextField.frame = CGRect(x: viewWidth*0.1, y: (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR)+loginViewHeight*0.35, width: viewWidth*0.8, height: loginViewHeight*0.1)
        passWordTextField.text = "パスワード"
        passWordTextField.textColor = UIColor.gray
        passWordTextField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(passWordTextField)
        
        //LoginButton
        let loginBtn:UIButton = UIButton()
        loginBtn.frame = CGRect(x: viewWidth*0.1, y: (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR)+loginViewHeight*0.55, width: viewWidth*0.8, height: loginViewHeight*0.1)
        loginBtn.backgroundColor = UIColor.gray
        loginBtn.setTitle("ログイン", for: UIControlState.normal)
        self.view.addSubview(loginBtn)
        
        //ResisterButton
        let resisterBtn:UIButton = UIButton()
        resisterBtn.frame = CGRect(x: viewWidth*0.1, y: (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR)+loginViewHeight*0.7, width: viewWidth*0.8, height: loginViewHeight*0.1)
        resisterBtn.backgroundColor = UIColor.LogInPinkColor()
        resisterBtn.setTitle("アカウント登録", for: UIControlState.normal)
        self.view.addSubview(resisterBtn)
        
        //ForgetPassWordButton
        let forgetPassWordButton:UIButton = UIButton()
        forgetPassWordButton.frame = CGRect(x: viewWidth*0.1, y: (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR)+loginViewHeight*0.85, width: viewWidth*0.8, height: loginViewHeight*0.1)
        forgetPassWordButton.backgroundColor = UIColor.white
        forgetPassWordButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        forgetPassWordButton.setTitle("パスワードを忘れた方", for: UIControlState.normal)
        self.view.addSubview(forgetPassWordButton)
        
    }
    
    //左側のボタンが押されたら呼ばれる
    func leftBarBtnClicked(sender: UIButton){

        self.dismiss(animated: true, completion: nil)
    }

}
