//
//  FollowUserButton.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/26.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class FollowUserButton: UIButton {
    
    var followBtn:UIButton!
    var followImgView:UIImageView!
    var followLabel:UILabel!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //アイコン
        followImgView = UIImageView()
        followImgView.image = UIImage(named: "userIcon")!

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
        followImgView.frame = CGRect(x: 0, y: viewHeight*0.1, width: viewWidth*0.25, height: viewHeight*0.8)
        followLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.7, height: viewHeight)
    }

}

