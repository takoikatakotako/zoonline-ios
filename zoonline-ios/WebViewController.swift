//
//  ContactViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class WebViewController: UIViewController , UIWebViewDelegate{
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    var statusBarHeight:CGFloat!
    var navigationBarHeight:CGFloat!
    
    private var webViewHeight:CGFloat!
    
    //
    var url:String!
    var navTitle:String!
    
    //
    var webview : UIWebView!
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        webViewHeight = viewHeight - (statusBarHeight+navigationBarHeight)
        
        //WebView
        webview = UIWebView()
        webview.frame = CGRect(x: 0, y: (statusBarHeight+navigationBarHeight), width: viewWidth, height: webViewHeight)
        webview.delegate = self
        self.view.addSubview(webview)
        
        // URLを設定.
        let url: URL = URL(string: self.url)!
        
        // リエストを発行する.
        let request: NSURLRequest = NSURLRequest(url: url)
        
        // リクエストを発行する.
        webview.loadRequest(request as URLRequest)
        
        // Viewに追加する
        self.view.addSubview(webview)
        
        setNavigationBar()
        
        setActivityIndicator()
    }
    
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        //ステータスバー部分の覆い
        let aadView:UIView = UIView()
        aadView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: statusBarHeight*2)
        aadView.backgroundColor = UIColor.MainAppColor()
        self.view.addSubview(aadView)
        
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
        titleLabel.text = navTitle
        titleLabel.textColor = UIColor.white
        navItems.titleView = titleLabel
        navBar.pushItem(navItems, animated: true)
        
        
        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(doClose(sender:)))
        navItems.leftBarButtonItem = leftNavBtn
        self.view.addSubview(navBar)
    }
    
    
    // MARK: くるくるの生成
    func setActivityIndicator(){
        
        indicator.frame = CGRect(x: viewWidth*0.35, y: viewHeight*0.4, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        indicator.color = UIColor.MainAppColor()
        self.view.bringSubviewToFront(indicator)
        indicator.color = UIColor.white
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    @objc func doClose(sender: UIButton){
    
        self.dismiss(animated: true, completion: nil)
    }
    
    

    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("webViewDidFinishLoad")
        indicator.stopAnimating()
    }
    
    /*
     PageがLoadされ始めた時、呼ばれる.
     */
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("webViewDidStartLoad")
    }
    

}
