//
//  LeftPicturesTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/23.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class LeftPicturesTableViewCell: UITableViewCell {

    var picturesImgView0:UIImageView!
    var picturesImgView1:UIImageView!
    var picturesImgView2:UIImageView!
    var picturesImgView3:UIImageView!
    var picturesImgView4:UIImageView!
    var picturesImgView5:UIImageView!
    
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

        picturesImgs[0].frame = CGRect(x: 0, y: 0, width: cellWidth*2/3, height: cellWidth*2/3)
        picturesImgs[1].frame = CGRect(x: cellWidth*2/3, y: 0, width: cellWidth*1/3, height: cellWidth*1/3)
        picturesImgs[2].frame = CGRect(x: cellWidth*2/3, y: cellWidth*1/3, width: cellWidth*1/3, height: cellWidth*1/3)
        picturesImgs[3].frame = CGRect(x: 0, y: cellWidth*2/3, width: cellWidth*1/3, height: cellWidth*1/3)
        picturesImgs[4].frame = CGRect(x: cellWidth*1/3, y: cellWidth*2/3, width: cellWidth*1/3, height: cellWidth*1/3)
        picturesImgs[5].frame = CGRect(x: cellWidth*2/3, y: cellWidth*2/3, width: cellWidth*1/3, height: cellWidth*1/3)
    }
}
