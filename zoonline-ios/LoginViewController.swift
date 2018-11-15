//
//  LoginViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/12.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController ,UITextFieldDelegate{

    //width,height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    var statusBarHeight:CGFloat!
    var navigationBarHeight:CGFloat!
    private var mailTextFieldHeight:CGFloat!
    private var passwordTextFieldHeight:CGFloat!
    private var loginBtnHeight:CGFloat!
    private var forgetPassWordBtnHeight:CGFloat!
    private var loginViewHeight:CGFloat!
    
    //ViewParts
    var mailTextField:UITextField!
    var passWordTextField:UITextField!
    var loginBtn:UIButton!
    
    //
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        mailTextFieldHeight = viewWidth*0.15
        passwordTextFieldHeight = viewWidth*0.15
        loginBtnHeight = viewWidth*0.15
        forgetPassWordBtnHeight = viewWidth*0.15
        loginViewHeight = viewHeight - (statusBarHeight+navigationBarHeight)
        
        self.view.backgroundColor = UIColor.white
        //Viewにパーツを追加
        setNavigationBar()
        setView()
        
        //Indicator
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        self.view.bringSubview(toFront: indicator)
        indicator.color = UIColor.MainAppColor()
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        //ステータスバー部分の覆い
        let statusView:UIView = UIView()
        statusView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: statusBarHeight*2)
        statusView.backgroundColor = UIColor.MainAppColor()
        self.view.addSubview(statusView)
        
        //ナビゲーションコントローラーの色の変更
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: statusBarHeight, width: viewWidth, height: navigationBarHeight)
        navBar.barTintColor = UIColor.MainAppColor()
        navBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let navItems = UINavigationItem()
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
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
        
        //テキストフィールドのパディング
        let mailTextFieldPadding = UIView()
        mailTextFieldPadding.frame = CGRect(x: 0, y: 0, width: 20, height: mailTextFieldHeight)
        let passWordTextFieldPadding = UIView()
        passWordTextFieldPadding.frame = CGRect(x: 0, y: 0, width: 20, height: mailTextFieldHeight)

        //MailTest
        let mailTextFieldYPos = statusBarHeight+navigationBarHeight
        mailTextField = UITextField()
        mailTextField.delegate = self
        mailTextField.frame = CGRect(x: 0, y: mailTextFieldYPos, width: viewWidth, height: mailTextFieldHeight)
        mailTextField.tag = 100
        mailTextField.text = "ユーザー名またはメールアドレス"
        mailTextField.textColor = UIColor.gray
        mailTextField.borderStyle = UITextBorderStyle.none
        mailTextField.font = UIFont.systemFont(ofSize: 16)
        mailTextField.backgroundColor = UIColor.white
        mailTextField.leftView = mailTextFieldPadding
        mailTextField.leftViewMode = UITextFieldViewMode.always
        self.view.addSubview(mailTextField)
        
        //MailUnderLine
        let mailTextFieldLine:UIView = UIView()
        mailTextFieldLine.frame = CGRect(x: 0, y: mailTextFieldYPos+mailTextFieldHeight, width: viewWidth, height: 1)
        mailTextFieldLine.backgroundColor = UIColor.gray
        self.view.addSubview(mailTextFieldLine)
        
        //PassTest
        let passTextYPos = mailTextFieldYPos + mailTextFieldHeight + 1
        passWordTextField = UITextField()
        passWordTextField.delegate = self
        passWordTextField.frame = CGRect(x: 0, y: passTextYPos, width: viewWidth, height: passwordTextFieldHeight)
        passWordTextField.tag = 101
        passWordTextField.text = "パスワード"
        passWordTextField.textColor = UIColor.gray
        passWordTextField.borderStyle = UITextBorderStyle.none
        passWordTextField.leftView = passWordTextFieldPadding
        passWordTextField.leftViewMode = UITextFieldViewMode.always
        self.view.addSubview(passWordTextField)
        
        //MailUnderLine
        let passWordTextFieldLine:UIView = UIView()
        passWordTextFieldLine.frame = CGRect(x: 0, y: passTextYPos+passwordTextFieldHeight, width: viewWidth, height: 1)
        passWordTextFieldLine.backgroundColor = UIColor.gray
        self.view.addSubview(passWordTextFieldLine)
        
        //LoginButton
        let loginBtnYPos = passTextYPos + passwordTextFieldHeight + 1 + viewWidth*0.05
        loginBtn = UIButton()
        loginBtn.frame = CGRect(x: viewWidth*0.1, y: loginBtnYPos, width: viewWidth*0.8, height: loginBtnHeight)
        loginBtn.backgroundColor = UIColor.gray
        loginBtn.setTitle("ログイン", for: UIControlState.normal)
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 4.0
        loginBtn.isEnabled = false
        loginBtn.addTarget(self, action: #selector(loginBtnClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        
        //ForgetPassWordButton
        let forgetPassWordBtnYPos = loginBtnYPos + forgetPassWordBtnHeight
        let forgetPassWordBtn:UIButton = UIButton()
        forgetPassWordBtn.frame = CGRect(x: viewWidth*0.1, y: forgetPassWordBtnYPos, width: viewWidth*0.8, height: forgetPassWordBtnHeight)
        forgetPassWordBtn.backgroundColor = UIColor.white
        forgetPassWordBtn.setTitleColor(UIColor.MainAppColor(), for: UIControlState.normal)
        forgetPassWordBtn.setTitle("パスワードを忘れた方", for: UIControlState.normal)
        forgetPassWordBtn.addTarget(self, action: #selector(forgetPassWordBtnClicked(sender:)), for: .touchUpInside)
       // self.view.addSubview(forgetPassWordBtn)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
        
        //初期入力値の場合は空にする
        if textField.text == "ユーザー名またはメールアドレス"{
            textField.text = ""
        }
        
        if  textField.text == "パスワード" {
            textField.text = ""
            passWordTextField.isSecureTextEntry = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        print(string)
        
        //ChangeLoginBtn
        if self.mailTextField.text == "メールアドレス" || self.passWordTextField.text == "パスワード" {
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = UIColor.gray
        }else if (self.mailTextField.text?.isEmpty)! || (self.passWordTextField.text?.isEmpty)!{
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = UIColor.gray
        } else{
            loginBtn.isEnabled = true
            loginBtn.backgroundColor = UIColor.LoginRegistSkyBlue()
        }
        
        return true
    }
    
    
    //UITextFieldが編集された直後に呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text!)")
        //passWordTestの場合
        
    }
 
    
    //改行ボタンが押された際に呼ばれる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        
        // 改行ボタンが押されたらKeyboardを閉じる処理.
        textField.resignFirstResponder()

        return true
    }
    
    //ログインボタンが押されたら呼ばれる
    @objc func loginBtnClicked(sender: UIButton){
        print("touped")
        
        //self.loginFailed.isHidden = true
        indicator.startAnimating()
        
        //post:http://minzoo.herokuapp.com/api/v0/login
        
        //onojun@sommelier.com
        //password
        let parameters: Parameters!
        if self.mailTextField.text == "ero" {
            parameters = [
                "email": "onojun@sommelier.com",
                "password": "password"]
        }else{
            parameters = [
                "email": self.mailTextField.text ?? "",
                "password": self.passWordTextField.text ?? ""]
        }
        
        
        Alamofire.request(EveryZooAPI.getSignIn(), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
            
            
            self.indicator.stopAnimating()
            
            
            switch response.result {
            case .success:
                let json:JSON = JSON(response.result.value ?? kill)
                
                
                print(json)
                
                if json["data"].isEmpty{
                    
                    //メールなどが違うと判断
                    //self.loginFailed.isHidden = false
                    SCLAlertView().showInfo("ログイン失敗", subTitle: "メールアドレス、パスワードを確認してください。")
                }else{
                    
                    //ログイン成功
                    var myUserID:String = ""
                    var myUserName:String = ""
                    var myUserEmail:String = ""
                    var myUserIconUrl:String = ""
                    var myUserProfile:String = ""

                    var myAccessToken:String = ""
                    var myClientToken:String = ""
                    var myExpiry:String = ""
                    var myUniqID:String = ""
                    
                    myUserID = String(json["data"]["id"].intValue)
                    
                    if !json["data"]["name"].stringValue.isEmpty {
                        myUserName = json["data"]["name"].stringValue
                    }
                    
                    if !json["data"]["email"].stringValue.isEmpty {
                        myUserEmail = json["data"]["email"].stringValue
                    }
                    
                    if !json["data"]["icon_url"].stringValue.isEmpty {
                        myUserIconUrl = json["data"]["icon_url"].stringValue
                    }
                    
                    if !json["data"]["profile"].stringValue.isEmpty {
                        myUserProfile = json["data"]["profile"].stringValue
                    }
                    
                    if let accessToken = response.response?.allHeaderFields["Access-Token"] as? String {
                        myAccessToken = accessToken
                    }
                    
                    if let clientToken = response.response?.allHeaderFields["Client"] as? String {
                        myClientToken = clientToken
                    }
                    
                    if let expiry = response.response?.allHeaderFields["Expiry"] as? String {
                        myExpiry = expiry
                    }
                    
                    if let uid = response.response?.allHeaderFields["Uid"] as? String {
                        myUniqID = uid
                    }
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.userDefaultsManager?.doLogin(userID: myUserID, userName: myUserName, email: myUserEmail, iconUrl: myUserIconUrl, profile: myUserProfile, accessToken: myAccessToken, clientToken: myClientToken,expiry:myExpiry, uniqID:myUniqID)
                
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
    @objc func forgetPassWordBtnClicked(sender: UIButton){
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
