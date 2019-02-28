import UIKit

class UserInfoButton: UIButton {
    var userIcon: UIImageView!
    var userName: UILabel!
    var userInfoButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        userIcon = UIImageView()
        userIcon.image = UIImage(named: "common-icon-default")
        userIcon.isUserInteractionEnabled = false
        userIcon.clipsToBounds = true
        userIcon.backgroundColor = .red
        addSubview(userIcon)

        userName = UILabel()
        userName.text = "フォロー"
        userName.textAlignment =  NSTextAlignment.left
        userName.textColor = .gray
        userName.isUserInteractionEnabled = false
        addSubview(userName)

        // isHidden = true
        // backgroundColor = .red
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        let width = frame.width
        let height = frame.height
        let iconSize = CGSize(width: 40, height: 40)

        userIcon.frame = CGRect(x: 20, y: (height - iconSize.height) / 2, width: iconSize.width, height: iconSize.height)
        userIcon.layer.cornerRadius = 20
        userName.frame = CGRect(x: 72, y: 0, width: width - 72, height: height)
    }
}
