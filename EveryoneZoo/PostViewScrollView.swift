//
//  PostViewScrollView.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/10.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PostViewScrollView: UIScrollView {

    //
    var imgSelectBtn:UIButton! = UIButton()
    
    //コメント
    //コメントのView
    var commentBaseView:UIView! = UIView()
    
    //タグ
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewWidth:CGFloat = self.frame.width
        
        self.backgroundColor = UIColor.PostScrollBGColor()
        
        //画像
        let buttonImage:UIImage = UIImage(named: "photoimage")!
        imgSelectBtn.setBackgroundImage(buttonImage, for: UIControlState.normal)
        imgSelectBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth*0.62)
        imgSelectBtn.backgroundColor = UIColor.white
        self.addSubview(imgSelectBtn)
        
        //コメントのベース
        commentBaseView.frame = CGRect(x: 0, y: viewWidth*0.62+20, width: viewWidth, height: viewWidth*0.3)
        commentBaseView.backgroundColor = UIColor.white
        self.addSubview(commentBaseView)
        
        //コメントのアイコン
        let commentLabelImg:UIImageView = UIImageView()
        commentLabelImg.image = UIImage(named:"comment_blue")
        commentLabelImg.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        commentBaseView.addSubview(commentLabelImg)
        
        
        //タグのベース
        
        //タグのアイコン
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
