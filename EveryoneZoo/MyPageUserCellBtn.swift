//
//  MyPageUserCellBtn.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/14.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class MyPageUserCellBtn: UIButton {
    
    let iconImgView:UIImageView = UIImageView()
    let userNameLabel:UILabel = UILabel()
    let userMailAdressLabel:UILabel = UILabel()

    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)!
    }

    
    private func commonInit() {
        
        let viewWidth:CGFloat = self.frame.size.width
        let viewHeight:CGFloat = self.frame.size.height

        //アイコン
        iconImgView.image = UIImage(named:"sample_kabi1")
        iconImgView.frame = CGRect(x: viewHeight*0.1, y: viewHeight*0.1, width: viewHeight*0.8, height: viewHeight*0.8)
        iconImgView.backgroundColor = UIColor.white
        iconImgView.layer.cornerRadius = viewHeight*0.8/2
        iconImgView.layer.masksToBounds = true
        self.addSubview(iconImgView)
        
        //ユーザーラベル
        userNameLabel.text = "投稿者カビゴン"
        userNameLabel.font = UIFont.systemFont(ofSize: 24)
        userNameLabel.frame = CGRect(x: viewHeight*1.1, y: viewHeight*0.2, width: viewWidth*0.6, height: viewHeight*0.4)
        self.addSubview(userNameLabel)
        
        //メールアドレス
        userMailAdressLabel.text = "onojun@kabigon.com"
        userMailAdressLabel.font = UIFont.systemFont(ofSize: 14)
        userMailAdressLabel.frame = CGRect(x: viewHeight*1.1, y: viewHeight*0.6, width: viewWidth*0.6, height: viewHeight*0.3)
        self.addSubview(userMailAdressLabel)
    }
}