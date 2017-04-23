//
//  RightPicturesTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/23.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class RightPicturesTableViewCell: UITableViewCell {

    var picturesImgs:Array<UIImageView> = Array()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        for i in 0..<6 {
            
            let picturesImg:UIImageView = UIImageView()
            picturesImg.clipsToBounds = true
            picturesImgs.append(picturesImg)
            contentView.addSubview(picturesImgs[i])
        }
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
        let cellWidthThird:CGFloat = cellWidth/3
        let paddingWidth:CGFloat = cellWidth*0.01
        let cellBigWidth:CGFloat = cellWidth*2/3-paddingWidth*2
        let cellSmallWidth:CGFloat = cellWidth*1/3-paddingWidth*2
        for i in 0..<6 {
            picturesImgs[i].layer.cornerRadius = cellWidth*0.05
        }
        
        picturesImgs[0].frame = CGRect(x: paddingWidth, y: paddingWidth, width: cellSmallWidth, height: cellSmallWidth)
        picturesImgs[1].frame = CGRect(x: paddingWidth, y: cellWidthThird+paddingWidth, width: cellSmallWidth, height: cellSmallWidth)
        picturesImgs[2].frame = CGRect(x: cellWidthThird+paddingWidth, y: paddingWidth, width: cellBigWidth, height: cellBigWidth)
        picturesImgs[3].frame = CGRect(x: paddingWidth, y: cellWidthThird*2+paddingWidth, width: cellSmallWidth, height: cellSmallWidth)
        picturesImgs[4].frame = CGRect(x: cellWidthThird+paddingWidth, y: cellWidthThird*2+paddingWidth, width: cellSmallWidth, height: cellSmallWidth)
        picturesImgs[5].frame = CGRect(x: cellWidthThird*2+paddingWidth, y: cellWidthThird*2+paddingWidth, width: cellSmallWidth, height: cellSmallWidth)
    }
}
