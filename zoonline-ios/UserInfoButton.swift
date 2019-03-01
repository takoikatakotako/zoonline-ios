import UIKit
import FirebaseUI

class UserInfoButton: UIButton {
    var userIcon: UIImageView!
    var userName: UILabel!
    var userInfoButton: UIButton!

    convenience init(uid: String) {
        self.init()

        userIcon = UIImageView()
        userIcon.image = UIImage(named: "common-icon-default")
        userIcon.isUserInteractionEnabled = false
        userIcon.clipsToBounds = true
        userIcon.backgroundColor = .red
        addSubview(userIcon)

        userName = UILabel()
        userName.textAlignment =  NSTextAlignment.left
        userName.textColor = .gray
        userName.isUserInteractionEnabled = false
        addSubview(userName)

        featchUserName(uid: uid)
        featchUserIcon(uid: uid)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
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

    func featchUserName(uid: String) {
        User.featchUserName(uid: uid, completion: { (name, error) in
            if let error = error {
                self.userName.text = "エラー" + name + error.description
            }
            self.userName.text = name
        })
    }

    func featchUserIcon(uid: String) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child(User.getUserIconPath(uid: uid))
        userIcon.sd_setImage(with: reference, placeholderImage: UIImage(named: "common-icon-default"))
    }
}
