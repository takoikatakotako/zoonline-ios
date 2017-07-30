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
            
    }
}
