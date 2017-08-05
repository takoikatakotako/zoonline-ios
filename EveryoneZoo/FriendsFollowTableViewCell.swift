//
//  FriendsFollowTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/06.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class FriendsFollowTableViewCell: UITableViewCell {

    //icons
    var baseView:UIView! = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
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
        
        let cellWidth:CGFloat = self.frame.size.width
        let cellHeight:CGFloat = self.frame.size.height
        
        
        
    }

}
