//
//  NetWorkErrorTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/23.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class NetWorkErrorTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        
        let errorLabelHeight = cellHeight*0.1
        let conformLabelHeight = cellHeight*0.1
        let errorImgViewHeight = cellWidth-(errorLabelHeight+conformLabelHeight)

        //NetErrorLabel
        let errorLabel:UILabel = UILabel()
        errorLabel.frame = CGRect(x: 0, y: errorLabelHeight, width: cellWidth, height: errorLabelHeight)
        errorLabel.text = "ネットワークエラー"
        errorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        errorLabel.textColor = UIColor.PostDetailFavPink()
        errorLabel.textAlignment = NSTextAlignment.center
        self.addSubview(errorLabel)
        
        //Conform Label
        let conformLabel:UILabel = UILabel()
        conformLabel.frame = CGRect(x: 0, y: errorLabelHeight*2, width: cellWidth, height: conformLabelHeight)
        conformLabel.text = "通信を確認してください"
        conformLabel.textAlignment = NSTextAlignment.center
        conformLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(conformLabel)
        
        //Error Img View
        let errorImgView:UIImageView = UIImageView()
        errorImgView.image = UIImage(named:"chara_penpen")
        errorImgView.contentMode = UIView.ContentMode.scaleAspectFit
        errorImgView.frame = CGRect(x: 0, y: errorLabelHeight+conformLabelHeight*2, width: cellWidth, height: errorImgViewHeight)
        self.addSubview(errorImgView)
    }
}
