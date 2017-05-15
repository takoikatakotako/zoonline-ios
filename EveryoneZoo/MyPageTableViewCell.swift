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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        thumbnailImgView.image = UIImage(named: "sample_kabi1")
        contentView.addSubview(thumbnailImgView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //let cellWidth:CGFloat = self.frame.width
        let cellHeight:CGFloat = self.frame.height
        
        thumbnailImgView.frame = CGRect(x: cellHeight*0.3, y: cellHeight*0.1, width: cellHeight*0.8, height: cellHeight*0.8)
    }

}
