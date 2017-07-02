//
//  TagListTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/02.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class TagListTableViewCell: UITableViewCell {
    
    var tagLabel:UILabel = UILabel()
    var deleateBtn:UIButton = UIButton()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(tagLabel)
        
        self.contentView.addSubview(deleateBtn)
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
        tagLabel.frame =  CGRect(x: cellWidth*0, y: cellWidth*0.03, width: cellWidth*0.08, height: cellWidth*0.08)
        
        deleateBtn.frame =  CGRect(x: cellWidth-cellHeight, y:0, width: cellHeight, height: cellHeight)

    }

}
