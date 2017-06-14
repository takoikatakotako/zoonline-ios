//
//  PostViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/08.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var scrollViewHeight:CGFloat!

    //テーブルビューインスタンス
    var postScrollView:PostViewScrollView!
    var myImagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        scrollViewHeight = viewHeight - PARTS_HEIGHT_STATUS_BAR - PARTS_HEIGHT_NAVIGATION_BAR
        
        
        self.view.isUserInteractionEnabled = true
        
        setNavigationBar()
        
        postScrollView = PostViewScrollView(frame:CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR + PARTS_HEIGHT_NAVIGATION_BAR, width: viewWidth, height: scrollViewHeight))
        postScrollView.imgSelectBtn.addTarget(self, action: #selector(imageSelectBtnClicked(sender:)), for: .touchUpInside)
        postScrollView.titleTextField.delegate = self
        postScrollView.titleTextField.keyboardType = UIKeyboardType.twitter
        self.view.addSubview(postScrollView)
    }
    
    //MARK: Viewの設定
    func setNavigationBar() {
        
        //ステータスバー背景
        let statusBackColor = UIView()
        statusBackColor.frame = CGRect(x: 0, y: 0, width: viewWidth, height: PARTS_HEIGHT_STATUS_BAR)
        statusBackColor.backgroundColor = UIColor.mainAppColor()
        self.view.addSubview(statusBackColor)
        
        //ナビゲーションバーの作成
        UINavigationBar.appearance().tintColor = UIColor.white
        let myNavBar = UINavigationBar()
        myNavBar.frame = CGRect(x: 0, y: PARTS_HEIGHT_STATUS_BAR, width: viewWidth, height: PARTS_HEIGHT_NAVIGATION_BAR)
        myNavBar.barTintColor = UIColor.mainAppColor()
        myNavBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let myNavItems = UINavigationItem()
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: PARTS_HEIGHT_NAVIGATION_BAR)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "投稿する"
        titleLabel.textColor = UIColor.white
        myNavItems.titleView = titleLabel
        
        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(title: "リセット", style: .plain, target: self, action:  #selector(leftBarBtnClicked(sender:)))
        myNavItems.leftBarButtonItem = leftNavBtn
        
        //バーの右側に設置するボタンの作成
        let rightNavBtn = UIBarButtonItem(title: "投稿", style: .plain, target: self, action:  #selector(postBtnClicked(sender:)))
        myNavItems.rightBarButtonItem = rightNavBtn;
        
        //作成したNavItemをNavBarに追加する
        myNavBar.pushItem(myNavItems, animated: true)
        self.view.addSubview(myNavBar)
    }

    //MARK: ButtonActions
    
    //左側のボタンが押されたら呼ばれる
    internal func leftBarBtnClicked(sender: UIButton){
        print("leftBarBtnClicked")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //右側のボタンが押されたら呼ばれる
    internal func postBtnClicked(sender: UIButton){
        
    }

    //imageSelectボタンが押されたら呼ばれます
    func imageSelectBtnClicked(sender: UIButton){
        
        // インスタンス生成
        myImagePicker = UIImagePickerController()
        myImagePicker.delegate = self
        myImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        myImagePicker.navigationBar.barTintColor = UIColor.mainAppColor()
        myImagePicker.navigationBar.tintColor = UIColor.white
        myImagePicker.navigationBar.isTranslucent = false
        //myImagePicker.allowsEditing = false
        self.present(myImagePicker, animated: true, completion: nil)
    }
    
    
    //MARK: imagePickerControllerDelegateMethod

    //画像が選択された時に呼ばれる.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            postScrollView.imgSelectBtn.setBackgroundImage(image, for: UIControlState.normal)
        } else{
            print("Error")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //画像選択がキャンセルされた時に呼ばれる.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }

    
    //MARK: UITextFieldDelegateMethod

    
    //UITextFieldが編集された直前に呼ばれる
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
        if postScrollView.titleTextField.text == "タイトルをつけてみよう" {
            postScrollView.titleTextField.text = ""
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
        postScrollView.titleTextField.resignFirstResponder()
        
        return true
    }
    
    
    // 画面にタッチで呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if (postScrollView.titleTextField.isFirstResponder) {
            postScrollView.titleTextField.resignFirstResponder()
        }
    }

}
