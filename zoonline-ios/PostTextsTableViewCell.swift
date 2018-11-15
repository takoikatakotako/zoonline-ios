//
//  PostTextsTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/02.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PostTextsTableViewCell: UITableViewCell {

    var iconImageView:UIImageView = UIImageView()
    var postTextView:UITextView = UITextView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImageView.isUserInteractionEnabled = false
        self.contentView.addSubview(iconImageView)
        
        postTextView.isUserInteractionEnabled = false
        postTextView.isEditable = false
        postTextView.font = UIFont.systemFont(ofSize: 14)
        postTextView.textColor = UIColor.gray
        self.contentView.addSubview(postTextView)
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

        iconImageView.frame =  CGRect(x: cellWidth*0.06, y: cellWidth*0.03, width: cellWidth*0.08, height: cellWidth*0.08)
        postTextView.frame = CGRect(x: cellWidth*0.18, y: cellWidth*0.02, width: cellWidth*0.8, height: cellHeight-(cellWidth*0.02))
    }
}
