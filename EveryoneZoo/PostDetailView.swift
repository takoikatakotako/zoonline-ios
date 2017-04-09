//
//  PostDetailView.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/09.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PostDetailView: UIView {
    
/*
    var userBtn:UIButton?
    var userImg:UIImage?
    var userName:String?
    var isFollow:Bool?
    var postImg:UIImage?
    var favos:Array<String>?
    var favoCount:NSInteger?
    var postTime:NSDate?
    var postComment:String?
    var categorys:Array<String>?
    */
    
    //init(userBtn:UIButton, userImg:UIImage, postTime:NSDate, postComment:String?, categorys:Array<String>? ) {
    init(viewWidth:CGFloat,viewHeight:CGFloat) {
     
    /*
        self.s = s
        self.i = i
        self.userBtn = userBtn
 
 */
        super.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        
        let viewWidth:CGFloat = self.frame.width

        //ユーザーバー
        let userNavHeight = viewWidth*0.15
        let userBtn = UIButton()
        userBtn.frame = CGRect(x: 0, y: 0, width: viewWidth*0.6, height: userNavHeight)
        userBtn.backgroundColor = UIColor.white
        self.addSubview(userBtn)

        //ユーザーイメージ
        let userImgView = UIImageView()
        userImgView.image = UIImage(named: "sample_kabi1")!
        userImgView.frame = CGRect(x: userNavHeight*0.2, y: userNavHeight*0.1, width: userNavHeight*0.8, height: userNavHeight*0.8)
        userImgView.layer.cornerRadius = userNavHeight*0.4
        userImgView.clipsToBounds = true
        userBtn.addSubview(userImgView)
        
        //ユーザー名
        let userNameTextView:UILabel = UILabel()
        userNameTextView.text = "カビゴン"
        userNameTextView.font =  UIFont.systemFont(ofSize: 16.0)
        userNameTextView.textAlignment =  NSTextAlignment.left
        userNameTextView.frame = CGRect(x: userNavHeight*1.2, y: userNavHeight*0.1, width: viewWidth*0.3, height: userNavHeight*0.8)
        userNameTextView.backgroundColor = UIColor.white
        userBtn.addSubview(userNameTextView)
        
        //ユーザーのイメージ
        let postImgView = UIImageView()
        postImgView.image = UIImage(named: "sample_postImage")!
        postImgView.frame = CGRect(x: 0, y: userNavHeight, width: viewWidth, height: viewWidth)
        self.addSubview(postImgView)
        
        //画像の下のバー
        let favComentBar = UIView()
        favComentBar.frame = CGRect(x: 0, y: userNavHeight+viewWidth, width: viewWidth, height: userNavHeight)
        favComentBar.backgroundColor = UIColor.white
        self.addSubview(favComentBar)

        //お気にいり
        let favImageBtn:UIButton = UIButton()
        favImageBtn.frame = CGRect(x: userNavHeight*0.4, y: userNavHeight*0.3, width: userNavHeight*0.6, height: userNavHeight*0.6)
        favImageBtn.setBackgroundImage(UIImage(named: "fav_off")!, for: UIControlState.normal)
        //favImageBtn.backgroundColor  = UIColor.red
        favComentBar.addSubview(favImageBtn)

        //お気に入り数
        let favNumLabel = UILabel()
        favNumLabel.frame = CGRect(x: userNavHeight*1.2, y: userNavHeight*0.3, width: userNavHeight*0.6, height: userNavHeight*0.6)
        favNumLabel.text = "3"
        favComentBar.addSubview(favNumLabel)

        //コメント
        let commentImageBtn:UIButton = UIButton()
        commentImageBtn.frame = CGRect(x: viewWidth*0.3, y: userNavHeight*0.3, width: userNavHeight*0.6, height: userNavHeight*0.6)
        commentImageBtn.setBackgroundImage(UIImage(named: "comment")!, for: UIControlState.normal)
        //favImageBtn.backgroundColor  = UIColor.red
        favComentBar.addSubview(commentImageBtn)

        //コメント数
        let commentNumLabel = UILabel()
        commentNumLabel.frame = CGRect(x: viewWidth*0.3+userNavHeight*1.0, y: userNavHeight*0.4, width: userNavHeight*0.6, height: userNavHeight*0.6)
        commentNumLabel.text = "3"
        favComentBar.addSubview(commentNumLabel)
        
        //アクションボタン
        let actionBtn:UIButton = UIButton()
        actionBtn.frame = CGRect(x: viewWidth*0.85, y: userNavHeight*0.3, width: userNavHeight*0.6, height: userNavHeight*0.6)
        actionBtn.setBackgroundImage(UIImage(named: "action")!, for: UIControlState.normal)
        //favImageBtn.backgroundColor  = UIColor.red
        favComentBar.addSubview(actionBtn)
        
        
        //コメントとか欄
        let commentsView = UIView()
        commentsView.frame = CGRect(x: 0, y: userNavHeight*2+viewWidth, width: viewWidth, height: userNavHeight*2)
        commentsView.backgroundColor = UIColor.white
        self.addSubview(commentsView)
        
        //日にち
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: userNavHeight*0.5, y: 0, width: viewWidth*0.5, height: userNavHeight*0.4)
        dateLabel.text = "2017年4月1日"
        dateLabel.font =  UIFont.systemFont(ofSize: 14.0)
        dateLabel.textColor = UIColor.gray
        commentsView.addSubview(dateLabel)
        
        //コメント
        let commentLabel = UILabel()
        commentLabel.frame = CGRect(x: userNavHeight*0.5, y: userNavHeight*0.3, width: viewWidth-userNavHeight, height: userNavHeight)
        commentLabel.text = "天王寺動物園にてサイを見ました。思ったよりも大きかったです。"
        commentLabel.font =  UIFont.systemFont(ofSize: 14.0)
        commentLabel.textColor = UIColor.black
        commentLabel.numberOfLines = 2
        commentsView.addSubview(commentLabel)

        //タグ
        let categoryBtn1:UIButton = UIButton()
        categoryBtn1.frame = CGRect(x: userNavHeight*0.5, y: userNavHeight*1.3, width: viewWidth*0.6, height: userNavHeight*0.3)
        categoryBtn1.backgroundColor  = UIColor.categoryBg()
        categoryBtn1.setTitle("#天王寺動物園", for: UIControlState.normal)
        categoryBtn1.setTitleColor(UIColor.white, for: UIControlState.normal)
        commentsView.addSubview(categoryBtn1)

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    /*
    
    var subViewColor:UIColor
    var subViewMessage:String
    
    
    override init(frame: CGRect) {
        super.init(frame: frame) // calls designated initializer
    }
    
    convenience init(frame: CGRect, subViewColor: UIColor, subViewMessage: String){
        
        self.subViewColor = subViewColor
        self.subViewMessage = subViewMessage
        self.init(frame: frame) // calls the initializer above
        
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    
    
    /*
    public var iconBtn:UIButton!
    public var iconImg:UIImageView!
    override func draw(_ rect: CGRect) {

        //Icon
        let viewWidth = self.frame.width
        //let viewHeight = self.frame.height
        
        iconBtn = UIButton()
        iconBtn.frame = CGRect(x: 0, y: 0, width: viewWidth*0.5, height: viewWidth*0.15)
        iconBtn.backgroundColor = UIColor.red
        //iconBtn.setBackgroundImage(UIImage(named: "sample_kabi1")!, for: UIControlState.normal)
        self.addSubview(iconBtn)
        
        
        iconImg = UIImageView()
        iconImg.frame = CGRect(x: 50, y: 0, width: viewWidth*0.15, height: viewWidth*0.15)
        iconImg.backgroundColor = UIColor.yellow
        iconBtn.addSubview(iconImg)

    }*/
    

}
