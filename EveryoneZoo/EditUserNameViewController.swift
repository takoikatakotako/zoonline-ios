//
//  EditUserNameViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/11.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class EditUserNameViewController: UIViewController {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!

        self.view.backgroundColor = UIColor.white
        
        setNavigationBar()
        
        //卵アイコン
        let iconImgView:UIImageView = UIImageView()
        let iconImgViewHeight:CGFloat = viewWidth*0.28
        iconImgView.frame =  CGRect(x: viewWidth/2-iconImgViewHeight/2, y: viewHeight*0.05, width: iconImgViewHeight, height:iconImgViewHeight)
        iconImgView.layer.cornerRadius = iconImgViewHeight/2
        iconImgView.layer.masksToBounds = true
        iconImgView.image = UIImage(named:"sample_kabi1")
        self.view.addSubview(iconImgView)
        
        // 名前
        let nameLabel:UILabel = UILabel()
        nameLabel.frame = CGRect(x: viewWidth*0.05, y:  viewHeight*0.24, width: viewWidth*0.9, height:24)
        nameLabel.text = "ユーザー名を変更します"
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(nameLabel)
        
        //ユーザー名入力欄
        let userNameTextFIeld:UITextField = UITextField()
        userNameTextFIeld.text = "新しいユーザー名"
        userNameTextFIeld.textAlignment = NSTextAlignment.center
        userNameTextFIeld.frame = CGRect(x: viewWidth*0.05, y: viewHeight*0.3, width: viewWidth*0.9, height: 40)
        //userNameTextFIeld.isHidden = true
        userNameTextFIeld.textColor = UIColor.gray
        self.view.addSubview(userNameTextFIeld)
        
        
        //userNameTextFIeldUnderLine
        let userNameTextFIeldLine:UIView = UIView()
        userNameTextFIeldLine.frame = CGRect(x: viewWidth*0.05, y: viewHeight*0.3+40+2, width: viewWidth*0.9, height: 1)
        userNameTextFIeldLine.backgroundColor = UIColor.gray
        self.view.addSubview(userNameTextFIeldLine)
        
        
        
        
        //LoginButton
        let changeUserNameBtn:UIButton = UIButton()
        changeUserNameBtn.frame = CGRect(x: viewWidth*0.1, y: viewHeight*0.4, width: viewWidth*0.8, height: viewWidth*0.15)
        changeUserNameBtn.backgroundColor = UIColor.mainAppColor()
        changeUserNameBtn.setTitle("変更を保存", for: UIControlState.normal)
        changeUserNameBtn.layer.masksToBounds = true
        changeUserNameBtn.layer.cornerRadius = 4.0
        changeUserNameBtn.isEnabled = false
        //changeUserNameBtn.addTarget(self, action: #selector(loginBtnClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(changeUserNameBtn)
        
        
        
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = UILabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "ユーザー名の変更"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }

}
