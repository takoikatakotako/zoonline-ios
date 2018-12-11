import UIKit

class UserInfoView: UIView {

    //  各種高さ
    // Icon
    let userIconSize: CGFloat = 100

    // UserInfo
    var userThumbnail: UIImageView!
    var userName: UILabel!
    var userDescription: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor(named: "mypageArrowGray")

        // UserInfo
        userThumbnail = UIImageView()
        userThumbnail.image = UIImage(named: "common-icon-default")
        addSubview(userThumbnail)

        userName = UILabel()
        userName.text = "道県有事"
        userName.font = UIFont.systemFont(ofSize: 32)
        userName.textAlignment = .center
        addSubview(userName)

        userDescription = UILabel()
        userDescription.numberOfLines = 0
        userDescription.font = UIFont.systemFont(ofSize: 18)
        userDescription.text = "自己紹介自己紹介自己紹介自己紹介自己紹介自己紹介自己紹介自己紹介自己紹介自己自己紹介自己紹介自己自己紹介自己紹介自己紹介自己紹介"
        addSubview(userDescription)
    }

    override func layoutSubviews() {
        let width = frame.width

        // UserInfo
        userThumbnail.frame = CGRect(x: (width - userIconSize) / 2, y: 28, width: userIconSize, height: userIconSize)
        userThumbnail.layer.cornerRadius = userIconSize / 2
        userName.frame = CGRect(x: 0, y: 144, width: width, height: 32)
        userDescription.frame = CGRect(x: width * 0.05, y: 180, width: width * 0.9, height: 80)
    }
}
