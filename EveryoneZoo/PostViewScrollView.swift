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
    
    //タイトルのView
    var titleBaseView:UIView! = UIView()
    var titleTextField:UITextField = UITextField()
    
    //コメント
    //コメントのView
    var commentBaseView:UIView! = UIView()
    
    //タグ
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewWidth:CGFloat = self.frame.width
        let postButtonHeight:CGFloat = viewWidth*0.62
        let spaceHeight:CGFloat = viewWidth*0.04
        let titleHeight:CGFloat = viewWidth*0.15
        let commentHeight:CGFloat = viewWidth*0.3

        self.backgroundColor = UIColor.PostScrollBGColor()
        
        //画像
        let buttonImage:UIImage = UIImage(named: "photoimage")!
        imgSelectBtn.setBackgroundImage(buttonImage, for: UIControlState.normal)
        imgSelectBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: postButtonHeight)
        imgSelectBtn.backgroundColor = UIColor.white
        self.addSubview(imgSelectBtn)
        
        //タイトル
        titleBaseView.frame = CGRect(x: 0, y: postButtonHeight+spaceHeight, width: viewWidth, height: titleHeight)
        titleBaseView.backgroundColor = UIColor.white
        self.addSubview(titleBaseView)

        //TitleLogo
        let titleLogo:UIImageView = UIImageView()
        titleLogo.frame = CGRect(x: viewWidth*0.05, y: titleHeight*0.2, width: titleHeight*0.6, height: titleHeight*0.6)
        titleLogo.image = UIImage(named: "title_logo")!
        titleBaseView.addSubview(titleLogo)
        
        //TitleTextField
        titleTextField.frame = CGRect(x: viewWidth*0.05+titleHeight, y: 0, width: viewWidth-(titleHeight+viewWidth*0.05), height: titleHeight)
        titleTextField.text = "タイトルをつけてみよう"
        titleTextField.textColor = UIColor.gray
        //titleTextField.borderStyle = UITextBorderStyle.roundedRect
        titleBaseView.addSubview(titleTextField)
        
        //コメントのベース
        commentBaseView.frame = CGRect(x: 0, y: postButtonHeight+titleHeight+spaceHeight*2, width: viewWidth, height: commentHeight)
        commentBaseView.backgroundColor = UIColor.white
        self.addSubview(commentBaseView)
        
        //TitleLogo
        let commentLogo:UIImageView = UIImageView()
        commentLogo.frame = CGRect(x: viewWidth*0.05, y: titleHeight*0.2, width: titleHeight*0.6, height: titleHeight*0.6)
        commentLogo.image = UIImage(named: "comment_blue")!
        commentBaseView.addSubview(commentLogo)
        
        //CommnetTextField
        let commentTextView:UITextView = UITextView()
        commentTextView.frame = CGRect(x: viewWidth*0.05+titleHeight, y: titleHeight*0.2, width: viewWidth-(titleHeight+viewWidth*0.05), height: commentHeight-titleHeight*0.2)
        commentTextView.text = "コメントを書いてみよう"
        commentTextView.textColor = UIColor.gray
        commentTextView.textAlignment = NSTextAlignment.left
        //commentTextView.contentVerticalAlignment = UIControlContentVerticalAlignment.top
        //titleTextField.borderStyle = UITextBorderStyle.roundedRect
        commentBaseView.addSubview(commentTextView)
        
        
                        /*
        //コメントのアイコン
        let commentLabelImg:UIImageView = UIImageView()
        commentLabelImg.image = UIImage(named:"comment_blue")
        commentLabelImg.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        commentBaseView.addSubview(commentLabelImg)
        */
        
        //タグのベース
        
        //タグのアイコン
        
        
        self.contentSize = CGSize(width:viewWidth, height:self.frame.height*2)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //タッチイベントを有効にする
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        superview?.touchesBegan(touches, with: event)
        
    }
    
}
