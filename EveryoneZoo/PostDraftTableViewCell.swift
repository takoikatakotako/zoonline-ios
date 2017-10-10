//
//  PostDraftTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/31.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PostDraftTableViewCell: UITableViewCell {
    
    var thumbnailImgView:UIImageView = UIImageView()
    var postTitle:UILabel = UILabel()
    var postDetail:UILabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(thumbnailImgView)
        contentView.addSubview(postTitle)
        contentView.addSubview(postDetail)
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
        thumbnailImgView.frame = CGRect(x: cellWidth*0.05, y: cellHeight*0.1, width: cellHeight*0.9, height: cellHeight*0.9)
        thumbnailImgView.image = UIImage(named:"sample_kabi1")
        
        //CommentLabel
        postTitle.frame = CGRect(x: cellWidth*0.25, y: cellHeight*0.08, width: cellWidth*0.5, height: cellHeight*0.2)
        postTitle.font = UIFont.boldSystemFont(ofSize: 14)
        postTitle.text = "いろはにほへと"
        postTitle.textColor = UIColor.mainAppColor()
        
        //PostDetail
        postDetail.frame = CGRect(x: cellWidth*0.25, y: cellHeight*0.3, width: cellWidth*0.7, height: cellHeight*0.7)
        postDetail.font = UIFont.boldSystemFont(ofSize: 12)
        postDetail.text = "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ"
        postDetail.numberOfLines = 0
        postDetail.textColor = UIColor.gray
    }    
}
