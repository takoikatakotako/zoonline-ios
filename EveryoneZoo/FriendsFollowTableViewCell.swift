//
//  FriendsFollowTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/06.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class UserBtn: UIButton {
    
    var iconImgView:UIImageView!
    var userNameLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //アイコン
        iconImgView = UIImageView()
        iconImgView.image = UIImage(named:"action")
        self.addSubview(iconImgView)
        
        //ユーザー名
        userNameLabel = UILabel()
        self.addSubview(userNameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth:CGFloat = frame.width
        let viewHeight:CGFloat = frame.height
        
        //アイコン
        iconImgView.frame = CGRect(x: viewWidth*0.15, y: viewWidth*0.05, width: viewWidth*0.7, height: viewWidth*0.7)
        iconImgView.image = UIImage(named:"sample_kabi1")
        iconImgView.layer.cornerRadius = viewWidth*0.7/2
        iconImgView.layer.masksToBounds = true
        
        userNameLabel.frame = CGRect(x: viewWidth*0.05, y: viewWidth*0.8, width: viewWidth*0.9, height: viewHeight-viewWidth*0.8)
        userNameLabel.text = "同県カビゴン沖本小野ピクシー"
        userNameLabel.font = UIFont.systemFont(ofSize: 12)
        userNameLabel.numberOfLines = 0
    }
}

class FriendsFollowTableViewCell: UITableViewCell {

    //icons
    var baseViewLeft:UserBtn! = UserBtn()
    var baseViewCenter:UserBtn! = UserBtn()
    var baseViewRight:UserBtn! = UserBtn()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(baseViewLeft)
        self.contentView.addSubview(baseViewCenter)
        self.contentView.addSubview(baseViewRight)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cellWidth:CGFloat = self.frame.size.width
        let cellHeight:CGFloat = self.frame.size.height
      
        baseViewLeft.frame = CGRect(x: cellWidth*0.05, y: cellHeight*0.05, width: cellWidth*0.3, height: cellHeight*0.9)
        
        baseViewCenter.frame = CGRect(x: cellWidth*0.35, y: cellHeight*0.05, width: cellWidth*0.3, height: cellHeight*0.9)
        
        baseViewRight.frame = CGRect(x: cellWidth*0.65, y: cellHeight*0.05, width: cellWidth*0.3, height: cellHeight*0.9)
    }
}
