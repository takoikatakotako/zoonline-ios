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
        
        //self.contentView.backgroundColor = UIColor.blue
        tagLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(tagLabel)
        
        deleateBtn.setBackgroundImage(UIImage(named:"sample_kabi1"), for: UIControlState.normal)
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
        
        //#を先頭に追加
        tagLabel.text = "#"+tagLabel.text!
        tagLabel.textColor = UIColor.white
        tagLabel.font = UIFont.boldSystemFont(ofSize: 16)
        tagLabel.backgroundColor = UIColor.tagBGColor()

        //サイズの計算
        let frame:CGSize = CGSize(width: cellWidth*0.8, height: cellHeight*0.6)
        let rect:CGSize = tagLabel.sizeThatFits(frame)
        
        tagLabel.frame =  CGRect(x: 0, y: cellHeight*0.2, width: rect.width+cellWidth*0.05, height:cellHeight*0.6)
        deleateBtn.frame =  CGRect(x: cellWidth-cellHeight, y:0, width: cellHeight, height: cellHeight)
    }
}
