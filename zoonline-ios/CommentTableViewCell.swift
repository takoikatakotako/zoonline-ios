import UIKit

class CommentTableViewCell: UITableViewCell {
    
    
    var thumbnail: UIImageView!
    var userName: UILabel!
    var dateLabel: UILabel!
    var commentTextView: UITextView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        thumbnail = UIImageView()
        thumbnail.layer.masksToBounds = true
        thumbnail.isUserInteractionEnabled = true
        thumbnail.image = UIImage(named: "post-detail-follow-icon")
        contentView.addSubview(thumbnail)

        userName = UILabel()
        userName.text = "いろはにほへと"
        userName.font = UIFont.boldSystemFont(ofSize: 16)
        userName.textColor = UIColor(named: "main")
        userName.isUserInteractionEnabled = false
        contentView.addSubview(userName)

        dateLabel = UILabel()
        dateLabel.text = "2017年4月26日"
        dateLabel.isUserInteractionEnabled = false
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = UIColor.gray
        contentView.addSubview(dateLabel)

        commentTextView = UITextView()
        commentTextView.text = "天王寺動物園のサイさんを見ました。思ったより、大きかったです！！かっこよかったよ！！わたくし、結構サイってかっこいいと思うけど、評価されていない思うのよ"
        commentTextView.isUserInteractionEnabled = false
        commentTextView.font = UIFont.systemFont(ofSize: 16)
        commentTextView.isEditable = false
        commentTextView.isScrollEnabled = false
        commentTextView.textColor = UIColor.gray
        contentView.addSubview(commentTextView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = self.frame.width
        
        // Thumbnail
        thumbnail.frame = CGRect(x: 16, y: 8, width: 32, height: 32)
        thumbnail.layer.cornerRadius = 16
        
        // UserName
        userName.frame = CGRect(x: 64, y: 8, width: 120, height: 32)
        
        //dateLabel
        dateLabel.frame = CGRect(x: width - 100 - 16, y: 8, width: 100, height: 32)
        
        // comments
        let textViewSize = CommentTableViewCell.getTextViewSize(viewWidth: frame.width, textView: commentTextView)
        commentTextView.frame = CGRect(x: 64, y: 40, width: width - 64 - 16, height: textViewSize.height)
    }
    
    class func getTextViewSize(viewWidth: CGFloat, textView: UITextView) -> CGSize {
        return textView.sizeThatFits(CGSize(width: viewWidth - 64 - 16, height: 0))
    }
    
    // ViewControllerからCellの高さを計算する為に使用
    class func calcHeight(viewWidth: CGFloat, comments: String) -> CGFloat {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = comments
        let textViewSize = getTextViewSize(viewWidth: viewWidth, textView: textView)
        return 40 + textViewSize.height + 8
    }
}
