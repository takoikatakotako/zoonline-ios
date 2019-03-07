import UIKit

class MyProfileView: UIView {

    //  各種高さ
    // Icon
    let userIconSize: CGFloat = 100

    // UserInfo
    var userThumbnail: UIImageView!
    var userName: UILabel!
    var userEmail: UILabel!
    var plusIcon: UIImageView!
    var selectIcon: UIButton!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor(named: "backgroundGray")

        // UserInfo
        userThumbnail = UIImageView()
        userThumbnail.image = UIImage(named: "common-icon-default")
        userThumbnail.clipsToBounds = true
        addSubview(userThumbnail)

        userName = UILabel()
        userName.font = UIFont.systemFont(ofSize: 32)
        userName.textAlignment = .center
        addSubview(userName)

        userEmail = UILabel()
        userEmail.numberOfLines = 0
        userEmail.font = UIFont.systemFont(ofSize: 18)
        userEmail.textAlignment = .center
        addSubview(userEmail)

        plusIcon = UIImageView()
        plusIcon.image = UIImage(named: "iconChange")
        addSubview(plusIcon)

        // アイコン変更用のボタン
        selectIcon = UIButton()
        addSubview(selectIcon)
    }

    override func layoutSubviews() {
        let width = frame.width

        // UserInfo
        userThumbnail.frame.size = CGSize(width: userIconSize, height: userIconSize)
        userThumbnail.center.x = width / 2
        userThumbnail.center.y = 28 + userIconSize / 2
        userThumbnail.layer.cornerRadius = userIconSize / 2
        // TODO: sin 使って美しくしたい
        plusIcon.frame.size = CGSize(width: 28, height: 28)
        plusIcon.center.x =  width / 2 + (userIconSize / 2) / sqrt(2)
        plusIcon.center.y = 28 + userIconSize / 2 + (userIconSize / 2) / sqrt(2)
        userName.frame = CGRect(x: 0, y: 144, width: width, height: 36)
        userEmail.frame = CGRect(x: width * 0.05, y: 180, width: width * 0.9, height: 40)

        selectIcon.frame.size = CGSize(width: userIconSize * 1.5, height: userIconSize * 1.5)
        selectIcon.center.x = width / 2
        selectIcon.center.y = 28 + userIconSize / 2
    }
}
