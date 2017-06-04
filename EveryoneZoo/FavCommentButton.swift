//
//  FavCommentButton.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/06/04.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class FavCommentButton: UIButton {

    var imgView:UIImageView!
    var countLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //アイコン
        imgView = UIImageView()
        self.addSubview(imgView)
        
        //ラベル
        countLabel = UILabel()
        self.addSubview(countLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth:CGFloat = frame.width
        let viewHeight:CGFloat = frame.height
        imgView.frame = CGRect(x: 0, y: viewHeight*0.2, width: viewHeight*0.6, height: viewHeight*0.6)
        countLabel.frame = CGRect(x: viewHeight*0.8, y: 0, width: viewWidth-viewHeight*0.8, height: viewHeight)
    }
}
