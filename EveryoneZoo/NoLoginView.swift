//
//  NoLoginView.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/12.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class NoLoginView: UIView {

    var imgView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //アイコン
        imgView = UIImageView()
        imgView.image = UIImage(named:"login_sample")
        self.addSubview(imgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        imgView.frame = self.frame
    }
}
