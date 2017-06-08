//
//  ContactViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController , UIWebViewDelegate{
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    
    var webview : UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        
        webview = UIWebView()
        webview.frame = self.view.bounds
        self.view.addSubview(webview)
        
        
        // URLを設定.
        let url: URL = URL(string: "http://jmatome.sakura.ne.jp/science/contact.php")!
        
        // リエストを発行する.
        let request: NSURLRequest = NSURLRequest(url: url)
        
        // リクエストを発行する.
        webview.loadRequest(request as URLRequest)
        
        // Viewに追加する
        self.view.addSubview(webview)
        
        
        
        setNavigationBar()
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
        titleLabel.text = "お問い合わせ"
        titleLabel.textColor = UIColor.white
        navItems.titleView = titleLabel
        navBar.pushItem(navItems, animated: true)
        
        
        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(doClose(sender:)))
        navItems.leftBarButtonItem = leftNavBtn
        self.view.addSubview(navBar)
    }
    
    
    func doClose(sender: UIButton){
    
        self.dismiss(animated: true, completion: nil)
    }
    
    

    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("webViewDidFinishLoad")
    }
    
    /*
     PageがLoadされ始めた時、呼ばれる.
     */
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("webViewDidStartLoad")
    }
    

}
