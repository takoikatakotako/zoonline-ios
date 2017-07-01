//
//  NewResistViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/21.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class NewResistViewController: UIViewController,UITextFieldDelegate {
    
    //width,height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var resistViewHeight:CGFloat!
    
    //ViewParts
    private var contentsScrollView:UIScrollView!
    var logoImgView:UIImageView!
    var userNameTextField:UITextField! = UITextField()
    var mailTextField:UITextField! = UITextField()
    var passWordTextField:UITextField! = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        resistViewHeight = viewHeight - (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR)
        
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
        
        //BaseScrollView
        contentsScrollView = UIScrollView()
        contentsScrollView.frame =  CGRect(x: 0, y: (PARTS_HEIGHT_STATUS_BAR+PARTS_HEIGHT_NAVIGATION_BAR), width: viewWidth, height: resistViewHeight)
        //contentsScrollView.contentSize = CGSize(width:viewWidth, height:resistViewHeight*2)
        
        self.view.addSubview(contentsScrollView)
        
        //Logo
        logoImgView = UIImageView()
        logoImgView.image = UIImage(named:"logo")
        logoImgView.frame = CGRect(x: viewWidth*0.1, y: resistViewHeight*0.05, width: viewWidth*0.8, height: resistViewHeight*0.2)
        logoImgView.contentMode = UIViewContentMode.scaleAspectFit
        contentsScrollView.addSubview(logoImgView)
        
        //resist failed
        let resistFailed:UILabel = UILabel()
        resistFailed.text = "そのユーザー名は使用できません"
        resistFailed.textAlignment = NSTextAlignment.center
        resistFailed.frame = CGRect(x: viewWidth*0.1, y: resistViewHeight*0.28, width: viewWidth*0.8, height: resistViewHeight*0.1)
        resistFailed.textColor = UIColor.LogInPinkColor()
        resistFailed.sizeToFit()
        contentsScrollView.addSubview(resistFailed)
        
        //MailTest
        userNameTextField.delegate = self
        userNameTextField.tag = 100
        userNameTextField.frame = CGRect(x: viewWidth*0.1, y: resistViewHeight*0.38, width: viewWidth*0.8, height: resistViewHeight*0.1)
        userNameTextField.text = "ユーザー名"
        userNameTextField.textColor = UIColor.gray
        userNameTextField.borderStyle = UITextBorderStyle.none
        userNameTextField.font = UIFont.systemFont(ofSize: 16)
        //mailTextField.textAlignment = NSTextAlignment.center
        contentsScrollView.addSubview(userNameTextField)
        
        //MailUnderLine
        let userNameTextFieldLine:UIView = UIView()
        userNameTextFieldLine.frame = CGRect(x: viewWidth*0.1, y: resistViewHeight*0.48, width: viewWidth*0.8, height: 1)
        userNameTextFieldLine.backgroundColor = UIColor.gray
        contentsScrollView.addSubview(userNameTextFieldLine)
        
        //MailTest
        mailTextField.delegate = self
        mailTextField.tag = 101
        mailTextField.frame = CGRect(x: viewWidth*0.1, y: resistViewHeight*0.48, width: viewWidth*0.8, height: resistViewHeight*0.1)
        mailTextField.text = "メールアドレス"
        mailTextField.textColor = UIColor.gray
        mailTextField.borderStyle = UITextBorderStyle.none
        contentsScrollView.addSubview(mailTextField)
        
        //MailUnderLine
        let mailTextFieldLine:UIView = UIView()
        mailTextFieldLine.frame = CGRect(x: viewWidth*0.1, y: resistViewHeight*0.58, width: viewWidth*0.8, height: 1)
        mailTextFieldLine.backgroundColor = UIColor.gray
        contentsScrollView.addSubview(mailTextFieldLine)
        
        //MailTest
        passWordTextField.delegate = self
        passWordTextField.tag = 102
        passWordTextField.frame = CGRect(x: viewWidth*0.1, y: resistViewHeight*0.58, width: viewWidth*0.8, height: resistViewHeight*0.1)
        passWordTextField.text = "パスワード"
        passWordTextField.textColor = UIColor.gray
        passWordTextField.borderStyle = UITextBorderStyle.none
        contentsScrollView.addSubview(passWordTextField)
        
        //MailUnderLine
        let passWordTextFieldLine:UIView = UIView()
        passWordTextFieldLine.frame = CGRect(x: viewWidth*0.1, y: resistViewHeight*0.68, width: viewWidth*0.8, height: 1)
        passWordTextFieldLine.backgroundColor = UIColor.gray
        contentsScrollView.addSubview(passWordTextFieldLine)
        
        //LoginButton
        let resistBtn:UIButton = UIButton()
        resistBtn.frame = CGRect(x: viewWidth*0.1, y: resistViewHeight*0.75, width: viewWidth*0.8, height: viewWidth*0.15)
        resistBtn.backgroundColor = UIColor.gray
        resistBtn.layer.masksToBounds = true
        resistBtn.layer.cornerRadius = 4.0
        resistBtn.isEnabled = false
        resistBtn.setTitle("登録する", for: UIControlState.normal)
        contentsScrollView.addSubview(resistBtn)
        
        //利用規約ボタン
        let termOfServiceBtn:UIButton = UIButton()
        termOfServiceBtn.frame = CGRect(x: viewWidth*0.1, y: resistViewHeight*0.86, width: viewWidth*0.8, height: viewWidth*0.15)
        termOfServiceBtn.backgroundColor = UIColor.white
        termOfServiceBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        termOfServiceBtn.setTitle("利用規約", for: UIControlState.normal)
        termOfServiceBtn.addTarget(self, action: #selector(showWebTOS(sender:)), for: .touchUpInside)
        contentsScrollView.addSubview(termOfServiceBtn)
    }
    
    
    //TosのwebViewを開く
    func showWebTOS(sender: UIButton){
        
        //今だとコンタクト開いてしまうので、のちに修正必要
        let contactView:ContactViewController = ContactViewController()
        self.present(contactView, animated: true, completion: nil)
    }
    
    
    //編集が始まったら呼ばれる
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
        
        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: 0.2, timingParameters: timing)
        
        //テキストフィールドの位置によって上げる位置も変更する
        var textPos:CGFloat = 0
        if textField.tag == 101{
            textPos += textField.frame.height
        }else if textField.tag == 102{
            textPos += textField.frame.height*2
        }
        animator.addAnimations {
            //テキストフィールドの位置に合わせてちょっと動かす
            self.contentsScrollView.setContentOffset(CGPoint(x: 0, y: self.logoImgView.frame.minY+textPos), animated: true)
        }
        animator.startAnimation()
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
        
        return true
    }
    
    //左側のボタンが押されたら呼ばれる
    func leftBarBtnClicked(sender: UIButton){
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
