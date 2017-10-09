//
//  UserInfoTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/10/09.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    var iconImgView:UIImageView = UIImageView()
    var userNameLabel:UILabel = UILabel()
    var profileLabel:UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        iconImgView = UIImageView()
        iconImgView.image = UIImage(named:"icon_default")
        iconImgView.layer.masksToBounds = true

        userNameLabel = UILabel()
        userNameLabel.font =  UIFont.systemFont(ofSize: 24)

        userNameLabel.text = "いろはにほへと"
        userNameLabel.textAlignment = NSTextAlignment.center
        userNameLabel.textColor = UIColor.black
        
        profileLabel = UILabel()
        profileLabel.font = UIFont.systemFont(ofSize: 16)
        profileLabel.text = "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ"
        profileLabel.numberOfLines = 0
        profileLabel.textColor = UIColor.black
        profileLabel.textAlignment = NSTextAlignment.center
        
        contentView.addSubview(iconImgView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(profileLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cellWidth:CGFloat = self.frame.width
        let cellHeight:CGFloat = self.frame.height
        
        let iconWidth:CGFloat = cellWidth*0.24
        
        //ThumbnailUmg
        iconImgView.layer.cornerRadius = iconWidth/2
        iconImgView.frame = CGRect(x: (cellWidth-iconWidth)/2, y: cellHeight*0.1, width: iconWidth, height: iconWidth)
        
        //userNameLabel
        userNameLabel.frame = CGRect(x: cellWidth*0.05, y: cellHeight*0.5, width: cellWidth*0.9, height: cellHeight*0.15)

        //profileLabel
        profileLabel.frame = CGRect(x: cellWidth*0.05, y: cellHeight*0.65, width: cellWidth*0.9, height: cellHeight*0.3)

    }
}
