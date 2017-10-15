//
//  NoLoginView.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/12.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class NoLoginView: UIView {
    
    var claimLoginLabel:UILabel!
    var loginCanDoView:UIImageView!
    var loginBtn:UIButton!
    var newResisterBtn:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //LoginLabel
        claimLoginLabel = UILabel()
        claimLoginLabel.text = "投稿・タイムラインを利用する\nにはログインしてください"
        claimLoginLabel.numberOfLines = 0
        claimLoginLabel.textAlignment = NSTextAlignment.center
        self.addSubview(claimLoginLabel)
        
        //アイコン
        loginCanDoView = UIImageView()
        loginCanDoView.image = UIImage(named:"login_can_do")
        loginCanDoView.contentMode = UIViewContentMode.scaleAspectFit
        self.addSubview(loginCanDoView)
        
        //LoginBtn
        loginBtn = UIButton()
        loginBtn.setTitle("ログイン", for: UIControlState.normal)
        loginBtn.backgroundColor = UIColor.AccountRegistErrorPink()
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 4.0
        self.addSubview(loginBtn)
        
        //newResist
        newResisterBtn = UIButton()
        newResisterBtn.setTitle("アカウント登録", for: UIControlState.normal)
        newResisterBtn.backgroundColor = UIColor.AccountRegistErrorPink()
        newResisterBtn.layer.masksToBounds = true
        newResisterBtn.layer.cornerRadius = 4.0
        self.addSubview(newResisterBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let viewWidth:CGFloat = self.frame.width
        let viewHeight:CGFloat = self.frame.height
        
        claimLoginLabel.frame = CGRect(x: 0, y: viewHeight*0.1, width: viewWidth, height: viewHeight*0.1)
        loginCanDoView.frame = CGRect(x: viewWidth*0.1, y: viewHeight*0.15, width: viewWidth*0.8, height: viewHeight*0.4)
        loginBtn.frame = CGRect(x: viewWidth*0.1, y: viewHeight*0.6, width: viewWidth*0.8, height: viewWidth*0.15)
        newResisterBtn.frame = CGRect(x: viewWidth*0.1, y: viewHeight*0.75, width: viewWidth*0.8, height: viewWidth*0.15)
        
    }
}
