//
//  PostViewScrollView.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/10.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PostViewScrollView: UIScrollView {

    var imgSelectBtn:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewWidth:CGFloat = self.frame.width
        
        self.backgroundColor = UIColor.gray
        
        imgSelectBtn = UIButton()
        let buttonImage:UIImage = UIImage(named: "photoimage")!
        imgSelectBtn.setBackgroundImage(buttonImage, for: UIControlState.normal)
        imgSelectBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth*0.62)
        imgSelectBtn.backgroundColor = UIColor.white
        self.addSubview(imgSelectBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
