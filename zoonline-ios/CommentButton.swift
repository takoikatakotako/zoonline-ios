import UIKit

class CommentButton: UIButton {

    var commentIcon: UIImageView!
    var commentLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Comment
        commentIcon = UIImageView()
        commentIcon.image = UIImage(named: "post-detail-comment")
        addSubview(commentIcon)

        commentLabel = UILabel()
        commentLabel.textColor = UIColor(named: "textColorGray")
        commentLabel.font = UIFont.boldSystemFont(ofSize: 24)
        commentLabel.text = "--"
        addSubview(commentLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        let width = frame.width
        let height = frame.height
        let iconSize = CGSize(width: 30, height: 30)

        commentIcon.frame = CGRect(x: 20, y: (height - iconSize.height) / 2, width: iconSize.width, height: iconSize.height)
        commentLabel.frame = CGRect(x: 60, y: 0, width: width, height: height)
    }
}
