//
//  MyPagePostCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/30.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class MyPagePostCell: UITableViewCell {
    
    //thumbnail
    var thumbnailImg:UIImageView!
    
    //title
    var titleLabel:UILabel!
    
    //date
    var dateLabel:UILabel!
    
    //cooment
    var commentLabel:UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        thumbnailImg = UIImageView()
        thumbnailImg.image = UIImage(named: "sample_loading")
        thumbnailImg.contentMode = UIView.ContentMode.scaleAspectFill
        thumbnailImg.clipsToBounds = true
        self.contentView.addSubview(thumbnailImg)
        
        titleLabel = UILabel()
        titleLabel.text = "タイトルタイトルタイトルタイトルたい凸たいタイトルタイトルタイトルたい凸たい凸タイトタイトルタイトルタイトルたい凸たい凸タイト凸タイトル"
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.MainAppColor()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.contentView.addSubview(titleLabel)
        
        dateLabel  = UILabel()
        dateLabel.text = "2017年7月30日"
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textAlignment = NSTextAlignment.right
        dateLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(dateLabel)
        
        commentLabel = UILabel()
        commentLabel.numberOfLines = 0
        commentLabel.font = UIFont.systemFont(ofSize: 12)
        commentLabel.text = "お父さん、お父さんだ！れーみーふぁそー、あの、こんな姿じゃわからないかもしれないけど、エドワード、まだ牛乳嫌いだろ、そこまでいってないって。"
        self.contentView.addSubview(commentLabel)
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

        thumbnailImg.layer.cornerRadius = cellWidth*0.04
        thumbnailImg.frame =  CGRect(x: cellHeight*0.03, y: cellHeight*0.05, width: cellHeight*0.9, height: cellHeight*0.9)

        dateLabel.frame = CGRect(x: cellWidth*0.7, y: cellHeight*0.03, width: cellWidth*0.28, height: cellHeight*0.15)
        
        titleLabel.frame =  CGRect(x: cellHeight, y: cellHeight*0.18, width: cellWidth-cellHeight, height: cellHeight*0.35)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.8

        commentLabel.frame =  CGRect(x: cellHeight, y: cellHeight*0.5, width: cellWidth-cellHeight, height: cellHeight*0.5)
    }
}
