//
//  NewResistViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import SwiftyJSON

class NewResistViewController: UIViewController,UITextFieldDelegate {
    
    //width,height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    var statusBarHeight:CGFloat!
    var navigationBarHeight:CGFloat!
    private var textFieldHeight:CGFloat!
    private var loginBtnHeight:CGFloat!
    private var forgetPassWordBtnHeight:CGFloat!
    private var loginViewHeight:CGFloat!
    
    //ViewParts
    var mailTextField:UITextField!
    var userNameTextField:UITextField!
    var passWordTextField:UITextField!
    var registBtn:UIButton!
    
    //
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        textFieldHeight = viewWidth*0.15
        loginBtnHeight = viewWidth*0.15
        forgetPassWordBtnHeight = viewWidth*0.15
        loginViewHeight = viewHeight - (statusBarHeight+navigationBarHeight)
        
        self.view.backgroundColor = UIColor.white
        //Viewにパーツを追加
        setNavigationBar()
        setView()
        
        //Indicator
        indicator.style = .whiteLarge
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        indicator.color = UIColor.init(named: "main")
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        //ステータスバー部分の覆い
        let statusView:UIView = UIView()
        statusView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: statusBarHeight*2)
        statusView.backgroundColor = UIColor.init(named: "main")
        self.view.addSubview(statusView)
        
        //ナビゲーションコントローラーの色の変更
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: statusBarHeight, width: viewWidth, height: navigationBarHeight)
        navBar.barTintColor = UIColor.init(named: "main")
        navBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let navItems = UINavigationItem()
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "新規登録"
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
        
        //テキストフィールドのパディング
        let mailTextFieldPadding = UIView()
        mailTextFieldPadding.frame = CGRect(x: 0, y: 0, width: 20, height: textFieldHeight)
        let userNameTextFieldPadding = UIView()
        userNameTextFieldPadding.frame = CGRect(x: 0, y: 0, width: 20, height: textFieldHeight)
        let passWordTextFieldPadding = UIView()
        passWordTextFieldPadding.frame = CGRect(x: 0, y: 0, width: 20, height: textFieldHeight)
        
        //MailTest
        let mailTextFieldYPos = statusBarHeight+navigationBarHeight
        mailTextField = UITextField()
        mailTextField.delegate = self
        mailTextField.frame = CGRect(x: 0, y: mailTextFieldYPos, width: viewWidth, height: textFieldHeight)
        mailTextField.tag = 100
        mailTextField.text = "メールアドレス"
        mailTextField.textColor = UIColor.gray
        mailTextField.borderStyle = UITextField.BorderStyle.none
        mailTextField.font = UIFont.systemFont(ofSize: 16)
        mailTextField.backgroundColor = UIColor.white
        mailTextField.leftView = mailTextFieldPadding
        mailTextField.leftViewMode = UITextField.ViewMode.always
        self.view.addSubview(mailTextField)
        
        //MailUnderLine
        let mailTextFieldLine:UIView = UIView()
        mailTextFieldLine.frame = CGRect(x: 0, y: mailTextFieldYPos+textFieldHeight, width: viewWidth, height: 1)
        mailTextFieldLine.backgroundColor = UIColor.gray
        self.view.addSubview(mailTextFieldLine)
        
        
        //UserName
        let userNameTextYPos = mailTextFieldYPos + textFieldHeight + 1
        userNameTextField = UITextField()
        userNameTextField.delegate = self
        userNameTextField.frame = CGRect(x: 0, y: userNameTextYPos, width: viewWidth, height: textFieldHeight)
        userNameTextField.tag = 101
        userNameTextField.text = "ユーザー名"
        userNameTextField.textColor = UIColor.gray
        userNameTextField.borderStyle = UITextField.BorderStyle.none
        userNameTextField.leftView = userNameTextFieldPadding
        userNameTextField.leftViewMode = UITextField.ViewMode.always
        self.view.addSubview(userNameTextField)
        
        //UserUnderLine
        let userNameTextFieldLine:UIView = UIView()
        userNameTextFieldLine.frame = CGRect(x: 0, y: userNameTextYPos+textFieldHeight, width: viewWidth, height: 1)
        userNameTextFieldLine.backgroundColor = UIColor.gray
        self.view.addSubview(userNameTextFieldLine)
        
        
        //PassTest
        let passTextYPos = userNameTextYPos + textFieldHeight + 1
        passWordTextField = UITextField()
        passWordTextField.delegate = self
        passWordTextField.frame = CGRect(x: 0, y: passTextYPos, width: viewWidth, height: textFieldHeight)
        passWordTextField.tag = 101
        passWordTextField.text = "パスワード"
        passWordTextField.textColor = UIColor.gray
        passWordTextField.borderStyle = UITextField.BorderStyle.none
        passWordTextField.leftView = passWordTextFieldPadding
        passWordTextField.leftViewMode = UITextField.ViewMode.always
        self.view.addSubview(passWordTextField)
        
        //PassUnderLine
        let passWordTextFieldLine:UIView = UIView()
        passWordTextFieldLine.frame = CGRect(x: 0, y: passTextYPos+textFieldHeight, width: viewWidth, height: 1)
        passWordTextFieldLine.backgroundColor = UIColor.gray
        self.view.addSubview(passWordTextFieldLine)
        
        //ResistButton
        let registBtnYPos = passTextYPos + textFieldHeight + 1 + viewWidth*0.05
        registBtn = UIButton()
        registBtn.frame = CGRect(x: viewWidth*0.1, y: registBtnYPos, width: viewWidth*0.8, height: loginBtnHeight)
        registBtn.backgroundColor = UIColor.gray
        registBtn.setTitle("新規登録", for: UIControl.State.normal)
        registBtn.layer.masksToBounds = true
        registBtn.layer.cornerRadius = 4.0
        registBtn.isEnabled = false
        registBtn.addTarget(self, action: #selector(registBtnClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(registBtn)
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
        
        //初期入力値の場合は空にする
        if textField.text == "メールアドレス" || textField.text == "ユーザー名"{
            textField.text = ""
        }
        
        if  textField.text == "パスワード" {
            textField.text = ""
            passWordTextField.isSecureTextEntry = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(string)
        
        
        registBtn.isEnabled = true
        registBtn.backgroundColor = UIColor.LoginRegistSkyBlue()

        return true
    }
    
    
    //UITextFieldが編集された直後に呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text!)")
        //passWordTestの場合
        
        if !(self.mailTextField.text?.isEmpty)! && !(self.userNameTextField.text?.isEmpty)! && !(self.passWordTextField.text?.isEmpty)!{
        
            registBtn.isEnabled = true
            registBtn.backgroundColor = UIColor.LoginRegistSkyBlue()
        }else{
        
            registBtn.isEnabled = false
            registBtn.backgroundColor = UIColor.gray
        }
    }
    
    
    //改行ボタンが押された際に呼ばれる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        
        // 改行ボタンが押されたらKeyboardを閉じる処理.
        textField.resignFirstResponder()
        
        return true
    }
    
    //ログインボタンが押されたら呼ばれる
    @objc func registBtnClicked(sender: UIButton){
        print("touped")
        
        indicator.startAnimating()
        
        let mail:String = self.mailTextField.text!
        let userName:String = userNameTextField.text!
        let passWord:String = passWordTextField.text!
        
        if mail.isEmpty {
        
            SCLAlertView().showInfo("エラー", subTitle: "メールアドレスを確認しください")
        }
        if (userName.isEmpty) {
            
            SCLAlertView().showInfo("エラー", subTitle: "ユーザー名を確認しください")
        }
        
        if passWord.isEmpty {
            
            SCLAlertView().showInfo("エラー", subTitle: "パスワード確認しください")
        }
        

        let parameters: Parameters!
        parameters = [
            "email": mail,
            "name": userName,
            "password": passWord,
            "confirm_success_url":API_CONFIRM_SUCCESS_URL]
        
        Alamofire.request(EveryZooAPI.getSignUp(), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
            
            self.indicator.stopAnimating()
            
            switch response.result {
                
            case .success:
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                
                
                if json["status"].stringValue == "error" {
                    //エラー
                    SCLAlertView().showInfo("登録失敗", subTitle: "登録に失敗しました。メールアドレス、パスワードをご確認ください。")
                }else if json["status"].stringValue != "success"{
                    //原因不明
                    SCLAlertView().showInfo("登録失敗", subTitle: "予期せぬエラーです。")
                }else{
                    //登録成功

                    SCLAlertView().showInfo("会員登録成功", subTitle: "登録したメールアドレスに届いたメールから会員登録を完了させ、ログインしてください。")
                    self.dismiss(animated: true, completion: nil)
                }
                
            case .failure(let error):
                print(error)
                //通信に失敗と判断
                // self.loginFailed.isHidden = false
                SCLAlertView().showInfo("ログイン失敗", subTitle: "メールアドレス、パスワードを確認してください。")
            }
        }
    }
    
    
    //パスワード再発行ボタンが押された。
    func forgetPassWordBtnClicked(sender: UIButton){
        let alert = SCLAlertView()
        let txt = alert.addTextField(UtilityLibrary.getUserEmail())
        alert.addButton("発行") {
            print("Text value: \(String(describing: txt.text))")
            
        }
        alert.showEdit("パスワード再発行", subTitle: "メールアドレスを入力してください。")
    }
    
    //左側のボタンが押されたら呼ばれる
    @objc func leftBarBtnClicked(sender: UIButton){
        
        self.dismiss(animated: true, completion: nil)
    }
}
