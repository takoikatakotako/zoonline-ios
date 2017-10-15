//
//  NetWorkErrorTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/23.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class NetWorkErrorTableViewCell: UITableViewCell {

    var errorImgView:UIImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(errorImgView)
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
        
        //NetErrorLabel
        let errorLabel:UILabel = UILabel()
        errorLabel.frame = CGRect(x: cellWidth*0.1, y: cellHeight*0.1, width: cellWidth*0.8, height: cellHeight*0.1)
        errorLabel.text = "ネットワークエラー"
        errorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        errorLabel.textColor = UIColor.PostDetailFavPink()
        errorLabel.textAlignment = NSTextAlignment.center
        self.addSubview(errorLabel)
        
        //Conform Label
        let conformLabel:UILabel = UILabel()
        conformLabel.frame = CGRect(x: cellWidth*0.1, y: cellHeight*0.2, width: cellWidth*0.8, height: cellHeight*0.1)
        conformLabel.text = "通信を確認してください"
        conformLabel.textAlignment = NSTextAlignment.center
        conformLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(conformLabel)
        
        errorImgView.image = UIImage(named:"chara_penpen")
        errorImgView.contentMode = UIViewContentMode.scaleAspectFit
        //errorImgView.a
        errorImgView.frame = CGRect(x: 0, y: cellHeight*0.32, width: cellWidth, height: cellHeight*0.68)
    }
}
