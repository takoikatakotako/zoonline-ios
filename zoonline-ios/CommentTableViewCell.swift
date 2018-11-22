import UIKit

class CommentTableViewCell: UITableViewCell {
    
    var thumbnailImgView:UIImageView!
    var commentUser:UILabel!
    var dateLabel:UILabel!
    var commentLabel:UITextView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        thumbnailImgView = UIImageView()
        thumbnailImgView.layer.masksToBounds = true
        thumbnailImgView.isUserInteractionEnabled = true
        thumbnailImgView.image = UIImage(named:"post-detail-follow-icon")
        contentView.addSubview(thumbnailImgView)

        commentUser = UILabel()
        commentUser.text = "いろはにほへと"
        commentUser.isUserInteractionEnabled = false
        
        dateLabel = UILabel()
        dateLabel.text = "2017年4月26日"
        dateLabel.isUserInteractionEnabled = false
        
        commentLabel = UITextView()
        commentLabel.text = "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ"
        commentLabel.isUserInteractionEnabled = false
        
        contentView.addSubview(commentUser)
        contentView.addSubview(dateLabel)
        contentView.addSubview(commentLabel)
        
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
        
        //ThumbnailUmg
        thumbnailImgView.frame = CGRect(x: cellWidth*0.05, y: cellWidth*0.28*0.15, width: cellWidth*0.28*0.35, height: cellWidth*0.28*0.35)
        thumbnailImgView.layer.cornerRadius = cellWidth*0.28*0.35/2
        
        //CommentLabel
        commentUser.frame = CGRect(x: cellWidth*0.18, y: cellWidth*0.28*0.08, width: cellWidth*0.5, height: cellWidth*0.28*0.35)
        commentUser.font = UIFont.boldSystemFont(ofSize: 14)
        commentUser.textColor = UIColor.init(named: "main")
        
        //dateLabel
        dateLabel.frame = CGRect(x: cellWidth*0.7, y: cellWidth*0.28*0.08, width: cellWidth*0.3, height: cellWidth*0.28*0.35)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = UIColor.gray
        
        commentLabel.frame = CGRect(x: cellWidth*0.18, y: cellWidth*0.28*0.35, width: cellWidth*0.8, height: 5)
        commentLabel.font = UIFont.systemFont(ofSize: 12)
        commentLabel.isEditable = false
        commentLabel.isScrollEnabled = false
        commentLabel.textColor = UIColor.gray
        commentLabel.sizeToFit()

    }

}
