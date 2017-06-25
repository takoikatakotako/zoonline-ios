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
    private var loginViewHeight:CGFloat!
    
    //ViewParts
    private var contentsScrollView:UIScrollView!
    var logoImgView:UIImageView!
    var mailTextField:UITextField! = UITextField()
    var passWordTextField:UITextField! = UITextField()
    var loginBtn:UIButton! = UIButton()
    
    
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
        let statusView:UIView = UIView()
        statusView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: PARTS_HEIGHT_STATUS_BAR*2)
        statusView.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusView)
        
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
        
        //BaseScrollView
        contentsScrollView = UIScrollView()
        contentsScrollView.frame =  CGRect(x: 0, y: (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR), width: viewWidth, height: loginViewHeight)
        //contentsScrollView.contentSize = CGSize(width:viewWidth, height:loginViewHeight*2)
        
        self.view.addSubview(contentsScrollView)
        
        //Logo
        logoImgView = UIImageView()
        logoImgView.image = UIImage(named:"logo")
        logoImgView.frame = CGRect(x: viewWidth*0.1, y: loginViewHeight*0.05, width: viewWidth*0.8, height: loginViewHeight*0.2)
        logoImgView.contentMode = UIViewContentMode.scaleAspectFit
        contentsScrollView.addSubview(logoImgView)
        
        //Login failed
        let loginFailed:UILabel = UILabel()
        loginFailed.text = "ログインできませんでした"
        loginFailed.textAlignment = NSTextAlignment.center
        loginFailed.frame = CGRect(x: viewWidth*0.1, y: loginViewHeight*0.25, width: viewWidth*0.8, height: loginViewHeight*0.1)
        loginFailed.textColor = UIColor.LogInPinkColor()
        contentsScrollView.addSubview(loginFailed)
        
        //MailTest
        mailTextField.delegate = self
        mailTextField.frame = CGRect(x: viewWidth*0.1, y: loginViewHeight*0.38, width: viewWidth*0.8, height: loginViewHeight*0.1)
        mailTextField.text = "ユーザー名またはメールアドレス"
        mailTextField.textColor = UIColor.gray
        mailTextField.borderStyle = UITextBorderStyle.none
        mailTextField.font = UIFont.systemFont(ofSize: 16)
        //mailTextField.textAlignment = NSTextAlignment.center
        contentsScrollView.addSubview(mailTextField)
        
        //MailUnderLine
        let mailTextFieldLine:UIView = UIView()
        mailTextFieldLine.frame = CGRect(x: viewWidth*0.1, y: loginViewHeight*0.48, width: viewWidth*0.8, height: 1)
        mailTextFieldLine.backgroundColor = UIColor.gray
        contentsScrollView.addSubview(mailTextFieldLine)
        
        //MailTest
        passWordTextField.delegate = self
        passWordTextField.frame = CGRect(x: viewWidth*0.1, y: loginViewHeight*0.48, width: viewWidth*0.8, height: loginViewHeight*0.1)
        passWordTextField.text = "パスワード"
        passWordTextField.textColor = UIColor.gray
        passWordTextField.borderStyle = UITextBorderStyle.none
        contentsScrollView.addSubview(passWordTextField)
        
        //MailUnderLine
        let passWordTextFieldLine:UIView = UIView()
        passWordTextFieldLine.frame = CGRect(x: viewWidth*0.1, y: loginViewHeight*0.58, width: viewWidth*0.8, height: 1)
        passWordTextFieldLine.backgroundColor = UIColor.gray
        contentsScrollView.addSubview(passWordTextFieldLine)
        
        //LoginButton
        loginBtn.frame = CGRect(x: viewWidth*0.1, y: loginViewHeight*0.65, width: viewWidth*0.8, height: viewWidth*0.15)
        loginBtn.backgroundColor = UIColor.gray
        loginBtn.setTitle("ログイン", for: UIControlState.normal)
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 4.0
        loginBtn.isEnabled = false
        loginBtn.addTarget(self, action: #selector(loginBtnClicked(sender:)), for: .touchUpInside)
        contentsScrollView.addSubview(loginBtn)
        
        //ForgetPassWordButton
        let forgetPassWordButton:UIButton = UIButton()
        forgetPassWordButton.frame = CGRect(x: viewWidth*0.1, y: loginViewHeight*0.8, width: viewWidth*0.8, height: viewWidth*0.15)
        forgetPassWordButton.backgroundColor = UIColor.white
        forgetPassWordButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        forgetPassWordButton.setTitle("パスワードを忘れた方", for: UIControlState.normal)
        contentsScrollView.addSubview(forgetPassWordButton)
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
        
        //ロゴの位置までViewを上げる
        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: timing)
        animator.addAnimations {
            self.contentsScrollView.setContentOffset(CGPoint(x: 0, y: self.logoImgView.frame.minY), animated: true)
        }
        animator.startAnimation()
        
        if textField.text == "ユーザー名またはメールアドレス" || textField.text == "パスワード" {
            textField.text = ""
        }
    }
    
    //UITextFieldが編集された直後に呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text!)")
        
    }
    
    //改行ボタンが押された際に呼ばれる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        
        // 改行ボタンが押されたらKeyboardを閉じる処理.
        textField.resignFirstResponder()
        
        //元の位置までViewを戻す
        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: timing)
        animator.addAnimations {
            self.contentsScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        animator.startAnimation()
        
        //ChangeLoginBtn
        if self.passWordTextField.text != "" || self.mailTextField.text != "" {
            loginBtn.isEnabled = true
            loginBtn.backgroundColor = UIColor.LoginBtnRightBlue()
        }else{
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = UIColor.gray
        }
        return true
    }
    
    //ログインボタンが押されたら呼ばれる
    func loginBtnClicked(sender: UIButton){
        print("touped")
        //
        
        //post:http://minzoo.herokuapp.com/api/v0/login
        
        //onojun@sommelier.com
        //password
        let parameters: Parameters = [
            "email": self.mailTextField.text ?? "",
            "password": self.passWordTextField.text ?? ""]
        
        Alamofire.request("http://minzoo.herokuapp.com/api/v0/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
                let json:JSON = JSON(response.result.value ?? kill)
                print(json["result"])
                
                if json["result"].boolValue{
                    //ログイン成功
                    self.dismiss(animated: true, completion: nil)
                }else{
                    //メールなどが違うと判断
                    SCLAlertView().showInfo("Important info", subTitle: "ログインに失敗しますた。たぶんパスとか違う")
                }
                
            case .failure(let error):
                print(error)
               //通信に失敗と判断
                SCLAlertView().showInfo("Important info", subTitle: "ログインに失敗しますた。たぶんネットワークエラー")
            }
        }
    }
    
    //左側のボタンが押されたら呼ばれる
    func leftBarBtnClicked(sender: UIButton){
        
        self.dismiss(animated: true, completion: nil)
    }
}
