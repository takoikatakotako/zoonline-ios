//
//  FieldCollectionViewCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/12/13.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class FieldCollectionViewCell: UICollectionViewCell {
    var thumbnailImgView : UIImageView?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // thumbnailImgを生成.
        thumbnailImgView = UIImageView()
        self.contentMode = UIViewContentMode.scaleAspectFill
        self.backgroundView = self.thumbnailImgView
    }
}
