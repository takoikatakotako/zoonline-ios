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
    var thumbnailImg:UIImageView! = UIImageView()
    
    //title
    var titleLabel:UILabel! = UILabel()
    
    //date
    var dateLabel:UILabel! = UILabel()
    
    //cooment
    var commentLabel:UILabel! = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(thumbnailImg)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(dateLabel)
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
        
        thumbnailImg.image = UIImage(named:"sample_kabi1")
        thumbnailImg.frame =  CGRect(x: cellHeight*0.05, y: cellHeight*0.05, width: cellHeight*0.9, height: cellHeight*0.9)
        
        titleLabel.frame =  CGRect(x: cellHeight, y: cellHeight*0.1, width: cellWidth-cellHeight, height: 0)
        titleLabel.text = "タイトル"
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.mainAppColor()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        //titleLabel.backgroundColor = UIColor.red
        
        dateLabel.frame = CGRect(x: cellWidth*0.7, y: cellHeight*0.15, width: cellWidth*0.3, height: 10)
        dateLabel.text = "2017年7月30日"
        dateLabel.sizeToFit()
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        //dateLabel.backgroundColor = UIColor.red

        commentLabel.frame =  CGRect(x: cellHeight, y: cellHeight*0.3, width: cellWidth-cellHeight, height: cellHeight*0.7)
        commentLabel.numberOfLines = 0
        commentLabel.font = UIFont.systemFont(ofSize: 12)
        commentLabel.text = "お父さん、お父さんだ！れーみーふぁそー、あの、こんな姿じゃわからないかもしれないけど、エドワード、まだ牛乳嫌いだろ、そこまでいってないって。"
        
    }
}
