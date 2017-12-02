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
    
    var supportBtn:SupportBtn!
    
    var pageName = 0
    
    // MARK: NavigationBar
    func setNavigationBarBar(navTitle:String){
        
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: statusBarHeight, width: viewWidth, height: navigationBarHeight)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.title = navTitle
    }
    
    // MARK: SupportBtn
    func setSupportBtn(btnHeight: CGFloat) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let didSupport:Bool = (appDelegate.userDefaultsManager?.userDefaults.bool(forKey: SupportBtn.getSupportKey(pageNum: pageName)))!
        if !didSupport && UtilityLibrary.isLogin(){
        
            supportBtn = SupportBtn()
            supportBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: btnHeight)
            supportBtn.setImage(UIImage(named:SupportBtn.getSupportImgName(pageNum: pageName)), for: UIControlState.normal)
            supportBtn.addTarget(self, action: #selector(supportBtnClicked(sender:)), for:.touchUpInside)
            self.view.addSubview(supportBtn)
        }
    }
    
    @objc func supportBtnClicked(sender: UIButton){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(true, forKey: SupportBtn.getSupportKey(pageNum: pageName))
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
