//
//  ConfigTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/16.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {
    
    var thumbnailImgView: UIImageView! = UIImageView()
    var textCellLabel:UILabel! = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(thumbnailImgView)
        contentView.addSubview(textCellLabel)
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
        
        //ThumbnailUmg
        thumbnailImgView.frame = CGRect(x: cellHeight*0.3, y: cellHeight*0.1, width: cellHeight*0.8, height: cellHeight*0.8)
        thumbnailImgView.layer.cornerRadius = cellHeight*0.8/2
        thumbnailImgView.layer.masksToBounds = true
        
        //TitleText
        textCellLabel.frame = CGRect(x: cellWidth*0.25, y: cellHeight*0.1, width: cellWidth*0.6, height: cellHeight*0.8)

    }

}
