//
//  RightPicturesTableViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/23.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class RightPicturesTableViewCell: UITableViewCell {

    var picturesBtn0:UIButton!
    var picturesBtn1:UIButton!
    var picturesBtn2:UIButton!
    var picturesBtn3:UIButton!
    var picturesBtn4:UIButton!
    var picturesBtn5:UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        picturesBtn0 = UIButton()
        picturesBtn0.clipsToBounds = true
        contentView.addSubview(picturesBtn0)
        
        picturesBtn1 = UIButton()
        picturesBtn1.clipsToBounds = true
        contentView.addSubview(picturesBtn1)
        
        picturesBtn2 = UIButton()
        picturesBtn2.clipsToBounds = true
        contentView.addSubview(picturesBtn2)
        
        picturesBtn3 = UIButton()
        picturesBtn3.clipsToBounds = true
        contentView.addSubview(picturesBtn3)
        
        picturesBtn4 = UIButton()
        picturesBtn4.clipsToBounds = true
        contentView.addSubview(picturesBtn4)
        
        picturesBtn5 = UIButton()
        picturesBtn5.clipsToBounds = true
        contentView.addSubview(picturesBtn5)
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
        
        picturesBtn0.setBackgroundImage(UIImage(named: "sample_kabi1")!, for: UIControlState.normal)
        picturesBtn1.setBackgroundImage(UIImage(named: "sample_kabi1")!, for: UIControlState.normal)
        picturesBtn2.setBackgroundImage(UIImage(named: "sample_kabi1")!, for: UIControlState.normal)
        picturesBtn3.setBackgroundImage(UIImage(named: "sample_kabi1")!, for: UIControlState.normal)
        picturesBtn4.setBackgroundImage(UIImage(named: "sample_kabi1")!, for: UIControlState.normal)
        picturesBtn5.setBackgroundImage(UIImage(named: "sample_kabi1")!, for: UIControlState.normal)
        
        picturesBtn0.frame = CGRect(x: 0, y: 0, width: cellWidth*1/3, height: cellWidth*1/3)
        picturesBtn1.frame = CGRect(x: 0, y: cellWidth*1/3, width: cellWidth*1/3, height: cellWidth*1/3)
        picturesBtn2.frame = CGRect(x: cellWidth*1/3, y: 0, width: cellWidth*2/3, height: cellWidth*2/3)
        picturesBtn3.frame = CGRect(x: 0, y: cellWidth*2/3, width: cellWidth*1/3, height: cellWidth*1/3)
        picturesBtn4.frame = CGRect(x: cellWidth*1/3, y: cellWidth*2/3, width: cellWidth*1/3, height: cellWidth*1/3)
        picturesBtn5.frame = CGRect(x: cellWidth*2/3, y: cellWidth*2/3, width: cellWidth*1/3, height: cellWidth*1/3)
    }

}
