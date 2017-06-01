//
//  PostDetailTableCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/22.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PostDetailTableCell: UITableViewCell {

    var userInfoBtn:UIButton!
    var thumbnailImgView:UIImageView!
    var userNameTextView:UILabel!
    
    var followBtn:FollowUserButton!

    var postImgView:UIImageView!
    var favImageBtn:UIButton!
    var favCountLabel:UILabel!
    var commentImageBtn:UIButton!
    var commentLabel:UILabel!
    var menuBtn:UIButton!
    var dateLabel:UILabel!
    var descriptionTextView:UITextView!
    var tag1Label:UILabel!
    var tag2Label:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        //UserInfoBtn
        userInfoBtn = UIButton()
        contentView.addSubview(userInfoBtn)
        
        thumbnailImgView = UIImageView()
        thumbnailImgView.clipsToBounds = true
        thumbnailImgView.image = UIImage(named:"tab_kabi")
        userInfoBtn.addSubview(thumbnailImgView)

        userNameTextView = UILabel()
        userNameTextView.textAlignment =  NSTextAlignment.left
        userNameTextView.text = "いろはにほへと"
        userInfoBtn.addSubview(userNameTextView)
    
        followBtn = FollowUserButton()
        
        postImgView = UIImageView()
        postImgView.image = UIImage(named: "sample_postImage")!
        contentView.addSubview(postImgView)
        
        favImageBtn = UIButton()
        favImageBtn.setBackgroundImage(UIImage(named: "fav_off")!, for: UIControlState.normal)
        contentView.addSubview(favImageBtn)
        
        favCountLabel = UILabel()
        favCountLabel.text = "10"
        favCountLabel.textAlignment =  NSTextAlignment.left
        favCountLabel.textColor = UIColor.followColor()
        favCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(favCountLabel)
        
        commentImageBtn = UIButton()
        commentImageBtn.setBackgroundImage(UIImage(named: "comment")!, for: UIControlState.normal)
        contentView.addSubview(commentImageBtn)

        commentLabel = UILabel()
        commentLabel.text = "5"
        commentLabel.textAlignment =  NSTextAlignment.left
        commentLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(commentLabel)
        
        menuBtn = UIButton()
        menuBtn.setBackgroundImage(UIImage(named: "action")!, for: UIControlState.normal)
        contentView.addSubview(menuBtn)
        
        dateLabel = UILabel()
        dateLabel.text = "2017年5月5日"
        dateLabel.font = UIFont.systemFont(ofSize: 16)
        dateLabel.textColor = UIColor.gray
        contentView.addSubview(dateLabel)
        
        descriptionTextView = UITextView()
        descriptionTextView.text = "天王寺動物園にサイをみました。思ったよりも大きかったです"
        descriptionTextView.textColor = UIColor.black
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.isEditable = false
        //descriptionTextView.isScrollEnabled = false
        contentView.addSubview(descriptionTextView)
        
        tag1Label = UILabel()
        tag1Label.text = "#天王寺動物園"
        tag1Label.textColor = UIColor.white
        tag1Label.backgroundColor = UIColor.tagBGColor()
        tag1Label.textAlignment = NSTextAlignment.center
        contentView.addSubview(tag1Label)

        tag2Label = UILabel()
        tag2Label.text = "#サイ"
        tag2Label.textColor = UIColor.white
        tag2Label.backgroundColor = UIColor.tagBGColor()
        tag2Label.textAlignment = NSTextAlignment.center
        contentView.addSubview(tag2Label)
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
        let cellHeight:CGFloat = self.frame.height

        //UserInfoBtn
        userInfoBtn.frame = CGRect(x: cellWidth*0.05, y: cellHeight*0.015, width: cellWidth*0.5, height: cellWidth*0.1)
        thumbnailImgView.frame = CGRect(x: 0, y: 0, width: cellWidth*0.1, height: cellWidth*0.1)
        thumbnailImgView.layer.cornerRadius = thumbnailImgView.frame.size.width * 0.5
        userNameTextView.frame = CGRect(x: cellWidth*0.13, y: 0, width: cellWidth*0.4, height: cellWidth*0.1)
        
        //FollowBtn
        followBtn.frame = CGRect(x: cellWidth*0.65, y: cellHeight*0.015, width: cellWidth*0.33, height: cellWidth*0.1)
        contentView.addSubview(followBtn)
        
        //PostImg
        postImgView.frame = CGRect(x: 0, y: cellHeight*0.09, width: cellWidth, height: cellWidth)
        postImgView.contentMode = UIViewContentMode.scaleAspectFit
        postImgView.backgroundColor = UIColor.white

        //
        favImageBtn.frame = CGRect(x: cellWidth*0.06, y: cellHeight*0.73, width: cellWidth*0.09, height: cellHeight*0.05)
        favCountLabel.frame = CGRect(x: cellWidth*0.17, y: cellHeight*0.73, width: cellWidth*0.15, height: cellHeight*0.05)
        
        commentImageBtn.frame = CGRect(x: cellWidth*0.29, y: cellHeight*0.73, width: cellWidth*0.09, height: cellHeight*0.05)
        commentLabel.frame = CGRect(x: cellWidth*0.40, y: cellHeight*0.73, width: cellWidth*0.09, height: cellHeight*0.05)
        
        menuBtn.frame = CGRect(x: cellWidth*0.84, y: cellHeight*0.73, width: cellWidth*0.09, height: cellHeight*0.05)
        
        dateLabel.frame = CGRect(x: cellWidth*0.06, y: cellHeight*0.8, width: cellWidth*0.5, height: cellHeight*0.03)

        descriptionTextView.frame = CGRect(x: cellWidth*0.04, y: cellHeight*0.83, width: cellWidth*0.92, height: cellHeight*0.1)

        tag1Label.frame = CGRect(x: cellWidth*0.05, y: cellHeight*0.93, width: cellWidth*0.4, height: cellHeight*0.04)
        tag2Label.frame = CGRect(x: cellWidth*0.55, y: cellHeight*0.93, width: cellWidth*0.4, height: cellHeight*0.04)
    }
}
