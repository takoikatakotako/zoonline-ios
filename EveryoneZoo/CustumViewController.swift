//
//  UIViewControllerExtension.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/11/16.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class CustumViewController:UIViewController {

    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    var statusBarHeight:CGFloat!
    var navigationBarHeight:CGFloat!
    var tabBarHeight:CGFloat!
    
    private var indicator:UIActivityIndicatorView!
    
    var supportBtn:UIButton!
        
    enum SupportKeyName: String {
        case Field = "KEY_SUPPORT_Field"
        case TimeLine = "KEY_SUPPORT_TimeLine"
        case Post = "KEY_SUPPORT_Post"
        case Official = "KEY_SUPPORT_Zoo"
        case Detail = "KEY_SUPPORT_PostDetail"
    }
    
    enum SupportImgName: String {
        case Field = "KEY_SUPPORT_Field"
        case TimeLine = "KEY_SUPPORT_TimeLine"
        case Post = "KEY_SUPPORT_Post"
        case Official = "KEY_SUPPORT_Zoo"
        case Detail = "KEY_SUPPORT_PostDetail"
    }
    
    
    // MARK: NavigationBar
    func setNavigationBarBar(navTitle:String){
        
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: statusBarHeight, width: viewWidth, height: navigationBarHeight)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = navTitle
    }
    
    // MARK: SupportBtn
    func setSupportBtn(btnHeight: CGFloat, imgName:String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let didSupport:Bool = (appDelegate.userDefaultsManager?.userDefaults.bool(forKey: "KEY_SUPPORT_TimeLine"))!
        if !didSupport && UtilityLibrary.isLogin(){
        
            supportBtn = UIButton()
            supportBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: btnHeight)
            supportBtn.setImage(UIImage(named:imgName), for: UIControlState.normal)
            supportBtn.imageView?.contentMode = UIViewContentMode.bottomRight
            supportBtn.contentHorizontalAlignment = .fill
            supportBtn.contentVerticalAlignment = .fill
            supportBtn.backgroundColor = UIColor.clear
            supportBtn.addTarget(self, action: #selector(supportBtnClicked(sender:)), for:.touchUpInside)
            self.view.addSubview(supportBtn)
        }
    }
    
    func supportBtnClicked(sender: UIButton){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(true, forKey: "KEY_SUPPORT_TimeLine")
        supportBtn.removeFromSuperview()
    }
    
    // MARK: Indicator
    func showIndicater() {
        let rv = UIApplication.shared.keyWindow! as UIWindow
        let width:CGFloat = rv.frame.size.width
        let height:CGFloat = rv.frame.size.height
        let indicatorSize:CGFloat = rv.frame.size.width * 0.4
        indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: (width-indicatorSize)/2, y: (height-indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        indicator.color = UIColor.MainAppColor()
        indicator.hidesWhenStopped = true
        rv.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func hideIndicator() {
        
        if let showingIndicator = indicator {
            showingIndicator.removeFromSuperview()
        }
    }
    
    //Mark: 未ログイン関係の処理
    
    //ログインボタンが押されたら呼ばれます
    func loginBtnClicked(sender: UIButton){
        
        let loginView:LoginViewController = LoginViewController()
        loginView.statusBarHeight = self.statusBarHeight
        loginView.navigationBarHeight = self.navigationBarHeight
        self.present(loginView, animated: true, completion: nil)
    }
    
    //登録ボタンが押されたら呼ばれます
    func resistBtnClicked(sender: UIButton){
        
        let loginView:NewResistViewController = NewResistViewController()
        loginView.statusBarHeight = self.statusBarHeight
        loginView.navigationBarHeight = self.navigationBarHeight
        self.present(loginView, animated: true, completion: nil)
    }
}
