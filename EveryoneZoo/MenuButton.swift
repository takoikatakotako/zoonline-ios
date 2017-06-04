//
//  MenuButton.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/04.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class MenuButton: UIButton {

    var imgView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //アイコン
        imgView = UIImageView()
        imgView.image = UIImage(named:"action")
        self.addSubview(imgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth:CGFloat = frame.width
        let viewHeight:CGFloat = frame.height

        imgView.frame = CGRect(x: viewWidth*0.2, y: viewHeight*0.2, width: viewHeight*0.6, height: viewHeight*0.6)
    }
}
