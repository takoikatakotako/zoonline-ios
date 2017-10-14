//
//  CommentTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/29.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    var thumbnailImgView:UIImageView = UIImageView()
    var commentUser:UILabel = UILabel()
    var dateLabel:UILabel = UILabel()
    var commentLabel:UITextView = UITextView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(thumbnailImgView)
        contentView.addSubview(commentUser)
        contentView.addSubview(dateLabel)
        contentView.addSubview(commentLabel)
        
        commentUser.text = "いろはにほへと"
        commentLabel.text = "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ"
        dateLabel.text = "2017年4月26日"
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
        thumbnailImgView.frame = CGRect(x: cellWidth*0.05, y: cellHeight*0.15, width: cellHeight*0.35, height: cellHeight*0.35)
        thumbnailImgView.layer.cornerRadius = cellHeight*0.35/2
        thumbnailImgView.layer.masksToBounds = true
        thumbnailImgView.image = UIImage(named:"sample_kabi1")
        
        //CommentLabel
        commentUser.frame = CGRect(x: cellWidth*0.18, y: cellHeight*0.08, width: cellWidth*0.5, height: cellHeight*0.35)
        commentUser.font = UIFont.boldSystemFont(ofSize: 14)
        commentUser.textColor = UIColor.MainAppColor()
        
        //dateLabel
        dateLabel.frame = CGRect(x: cellWidth*0.7, y: cellHeight*0.08, width: cellWidth*0.3, height: cellHeight*0.35)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = UIColor.gray
        
        commentLabel.frame = CGRect(x: cellWidth*0.18, y: cellHeight*0.35, width: cellWidth*0.8, height: cellHeight*0.6)
        commentLabel.font = UIFont.systemFont(ofSize: 12)
        commentLabel.isEditable = false
        commentLabel.isScrollEnabled = false
        commentLabel.textColor = UIColor.gray
        
    }

}
