import UIKit

class FollowButton: UIButton {

    var followIcon: UIImageView!
    var followLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        followIcon = UIImageView()
        followIcon.image = UIImage(named: "post-detail-follow-icon")
        followIcon.isUserInteractionEnabled = false
        addSubview(followIcon)

        followLabel = UILabel()
        followLabel.text = "フレンズ"
        followLabel.textColor = .gray
        followLabel.isUserInteractionEnabled = false
        addSubview(followLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        let width = frame.width
        let height = frame.height
        let iconSize = CGSize(width: 30, height: 30)
        let margin: CGFloat = 8
        let labelSize = CGSize(width: width - iconSize.width - margin, height: height)
        followIcon.frame = CGRect(x: 0, y: (height - iconSize.height) / 2, width: iconSize.width, height: iconSize.height)
        followLabel.frame = CGRect(x: iconSize.width + margin, y: 0, width: labelSize.width, height: labelSize.height)
    }
}
