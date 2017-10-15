//
//  PostDetailTableCell.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/04/22.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit

class PostDetailTableCell: UITableViewCell {

    //UserInfoBtn
    var userInfoBtn:UIButton!
    var thumbnailImgView:UIImageView!
    var userNameTextView:UILabel!
    
    //FollowBtn
    var followBtn:FollowUserButton!

    //PostView
    var postImgView:UIImageView!
    
    //FavImgBtn
    var favBtn:FavCommentButton!
    
    //CommentBtn
    var commentBtn:FavCommentButton!

    //MunuButton
    var menuBtn:MenuButton!
    
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
        thumbnailImgView.image = UIImage(named:"icon_default")
        userInfoBtn.addSubview(thumbnailImgView)

        userNameTextView = UILabel()
        userNameTextView.textAlignment =  NSTextAlignment.left
        userNameTextView.text = "いろはにほへと"
        userInfoBtn.addSubview(userNameTextView)
    
        //FollowBtn
        followBtn = FollowUserButton()
        contentView.addSubview(followBtn)

        //PostImg
        postImgView = UIImageView()
        postImgView.image = UIImage(named: "sample_loading")!
        postImgView.backgroundColor = UIColor.white
        postImgView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(postImgView)
        
        //FavImg
        favBtn = FavCommentButton()
        favBtn.imgView.image = UIImage(named: "fav_off")!
        favBtn.countLabel.textAlignment =  NSTextAlignment.left
        favBtn.countLabel.textColor = UIColor.PostDetailFavPink()
        favBtn.countLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(favBtn)

        //CommentBtn
        commentBtn = FavCommentButton()
        commentBtn.imgView.image = UIImage(named: "comment")!
        commentBtn.countLabel.textAlignment =  NSTextAlignment.left
        commentBtn.countLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(commentBtn)

        //MenuBtn
        menuBtn = MenuButton()
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
        descriptionTextView.isScrollEnabled = false
        contentView.addSubview(descriptionTextView)
        
        tag1Label = UILabel()
        tag1Label.text = "#天王寺動物園"
        tag1Label.textColor = UIColor.white
        tag1Label.backgroundColor = UIColor.PostDetailFavPink()
        tag1Label.textAlignment = NSTextAlignment.center
        contentView.addSubview(tag1Label)

        tag2Label = UILabel()
        tag2Label.text = "#サイ"
        tag2Label.textColor = UIColor.white
        tag2Label.backgroundColor = UIColor.PostDetailFavPink()
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
        //let cellWidth:CGFloat = self.frame.width
        //let cellHeight:CGFloat = self.frame.height

        
        
        /*
        tag1Label.frame = CGRect(x: cellWidth*0.05, y: cellHeight*0.93, width: cellWidth*0.4, height: cellHeight*0.04)
        tag2Label.frame = CGRect(x: cellWidth*0.55, y: cellHeight*0.93, width: cellWidth*0.4, height: cellHeight*0.04)
 
 */
    }
}
