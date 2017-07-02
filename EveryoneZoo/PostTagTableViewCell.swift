//
//  PostTagTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/02.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PostTagTableViewCell: UITableViewCell {

    var iconImageView:UIImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImageView.isUserInteractionEnabled = false
        iconImageView.image = UIImage(named:"tag_blue")
        self.contentView.addSubview(iconImageView)
        
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
        //let cellHeight:CGFloat = self.frame.height
        
        iconImageView.frame =  CGRect(x: cellWidth*0.06, y: cellWidth*0.03, width: cellWidth*0.08, height: cellWidth*0.08)
    }

}