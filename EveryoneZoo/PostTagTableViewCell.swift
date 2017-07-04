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
    var tagsAry:Array<String> = []
    let tagLabel:UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImageView.isUserInteractionEnabled = false
        iconImageView.image = UIImage(named:"tag_blue")
        self.contentView.addSubview(iconImageView)
        
        tagLabel.isUserInteractionEnabled = false
        tagLabel.font = UIFont.systemFont(ofSize: 14)
        tagLabel.textColor = UIColor.gray
        tagLabel.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(tagLabel)
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
        
        
        //self.contentView.removeAll
        
        if tagsAry.count == 0 {
            tagLabel.frame = CGRect(x: cellWidth*0.18, y: cellWidth*0.04, width: cellWidth*0.8, height: 0)
            tagLabel.sizeToFit()
        }else{
            tagLabel.removeFromSuperview()
            var count:CGFloat = 0
            let separatedHeight:CGFloat = cellHeight/CGFloat(tagsAry.count+1)
            for tag in tagsAry{
                let label:UILabel = UILabel()
                label.text = "#"+tag
                label.font = UIFont.boldSystemFont(ofSize: 16)
                label.backgroundColor = UIColor.tagBGColor()
                label.textColor = UIColor.white
                label.textAlignment = NSTextAlignment.center
                let frame:CGSize = CGSize(width: cellWidth*0.6, height: 0)
                let rect:CGSize = label.sizeThatFits(frame)
                label.frame = CGRect(x: cellWidth*0.2, y: separatedHeight*(0.65+count), width: rect.width+cellWidth*0.05, height: rect.height)
                self.contentView.addSubview(label)
                count += 1
            }
        }

        iconImageView.frame =  CGRect(x: cellWidth*0.06, y: cellWidth*0.03, width: cellWidth*0.08, height: cellWidth*0.08)
    }
}
