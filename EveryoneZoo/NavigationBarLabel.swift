//
//  NavigationBarLabel.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/07/11.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class NavigationBarLabel: UILabel {

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.white
        self.font = UIFont.boldSystemFont(ofSize: 18)
    }
}
