//
//  WritePostTextsViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/02.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

//MARK: step 1 Add Protocol here
protocol SetTextDelegate: class {
    
    func setTitle(str:String)
    func setComment(str:String)
}

class WritePostTextsViewController: UIViewController,UITextViewDelegate {

    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    
    //segue
    var isTitle:Bool!
    var navTitle:String!
    var text:String!
    
    //viewParts
    private var textView: UITextView = UITextView()
    
    
    weak var delegate: SetTextDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height

        self.view.backgroundColor = UIColor.white
        
        setNavigationBar()
        setTextView()
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        
        if isTitle {
            delegate?.setTitle(str: textView.text)
        }else{
            delegate?.setComment(str: textView.text)
        }
    }
    
    
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        //ナビゲーションコントローラーの色の変更
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        //「<戻る」を「<」のみにする
        navigationController!.navigationBar.topItem!.title = " "
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = navTitle
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
        
        //右上の検索ボタン
        //serchNavBtn.tintColor = UIColor.white
        //serchNavBtn.action = #selector(rightBarBtnClicked(sender:))
    }
    
    func setTextView(){
    
        textView.frame = CGRect(x: viewWidth*0.05, y: viewWidth*0.05, width: viewWidth*0.9, height: viewHeight-viewWidth*0.1)
        //textView.backgroundColor = UIColor.red
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        textView.text = text
        self.view.addSubview(textView)
    }
    
    
    //テキストビューが変更された
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    // テキストビューにフォーカスが移った
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if textView.text == "タイトルをつけてみよう" ||  textView.text == "コメントを書いてみよう"{
            textView.text = ""
        }
        return true
    }
    
    // テキストビューからフォーカスが失われた
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {

        return true
    }
    
    
    

}
