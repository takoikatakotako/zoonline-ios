//
//  FollowUserButton.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/26.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class FollowUserButton: UIButton {
    
    var followImgView:UIImageView!
    var followLabel:UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //アイコン
        followImgView = UIImageView()
        followImgView.image = UIImage(named: "follow_icon")!
        self.addSubview(followImgView)
        
        //ラベル
        followLabel = UILabel()
        followLabel.text = "フォロー"
        self.addSubview(followLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth:CGFloat = frame.width
        let viewHeight:CGFloat = frame.height
        followImgView.frame = CGRect(x: 0, y: viewHeight*0.25, width: viewHeight*0.5, height: viewHeight*0.5)
        followLabel.frame = CGRect(x: viewHeight*0.6, y: 0, width: viewWidth-viewHeight*0.6, height: viewHeight)
    }
}

