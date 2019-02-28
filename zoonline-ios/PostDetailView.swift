import UIKit
import Firebase

class PostDetailView: UIView {

    //
    private var post: Post!

    //  各種高さ
    // Iconとフォロー
    private let userInfoHeight: CGFloat = 60
    // Favoriteとコメントなど
    private let menuHeight: CGFloat = 60
    // Dateの高さ
    private let dateHeight: CGFloat = 20
    // テーブルビューまでのマージン
    let bottomMargin: CGFloat = 8

    // Viewのパーツ
    // UserInfo
    var userInfoButton: UserInfoButton!

    // Follow Info
    var followButton: FollowButton!

    // Image
    var postImage: UIImageView!

    // Favorite
    var favoriteButton: UIButton!
    var favoriteLabel: UILabel!

    // Comment
    var commentButton: UIButton!
    var commentLabel: UILabel!

    // Menu
    var menuButton: UIButton!

    // Date
    var dateLabel: UILabel!

    // Detail
    var detailTextView: UITextView!

    // BottomLine
    var bottomLine: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init(post: Post) {
        self.init()
        self.post = post

        // UserInfo
        userInfoButton = UserInfoButton()
        addSubview(userInfoButton)

        // Follow Info
        followButton = FollowButton()
        addSubview(followButton)

        // Image
        postImage = UIImageView()
        postImage.image = UIImage(named: "sample-postImage")
        addSubview(postImage)

        // Favorite
        favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(named: "post-detail-fav-on"), for: .normal)
        addSubview(favoriteButton)

        favoriteLabel = UILabel()
        favoriteLabel.textColor = UIColor(named: "postDetailFavPink")
        favoriteLabel.font = UIFont.boldSystemFont(ofSize: 24)
        favoriteLabel.text = "10"
        addSubview(favoriteLabel)

        // Comment
        commentButton = UIButton()
        commentButton.setImage(UIImage(named: "post-detail-comment"), for: .normal)
        addSubview(commentButton)

        commentLabel = UILabel()
        commentLabel.textColor = UIColor(named: "textColorGray")
        commentLabel.font = UIFont.boldSystemFont(ofSize: 24)
        commentLabel.text = "10"
        addSubview(commentLabel)

        // Menu
        menuButton = UIButton()
        menuButton.setImage(UIImage(named: "post-detail-menu"), for: .normal)
        addSubview(menuButton)

        // Date
        dateLabel = UILabel()
        dateLabel.text = post.createdAt.description
        dateLabel.textColor = UIColor(named: "textColorGray")
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        addSubview(dateLabel)

        // Detail
        detailTextView = UITextView()
        detailTextView.text = post.comment
        detailTextView.font = UIFont.systemFont(ofSize: 18)
        detailTextView.textAlignment = .left
        detailTextView.isEditable = false
        addSubview(detailTextView)

        // BottomLine
        bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(named: "mypageArrowGray")
        addSubview(bottomLine)

        // Featch FireBases
        featchUser(uid: post.uid)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func layoutSubviews() {
        let width = frame.width

        // UserInfo
        userInfoButton.frame = CGRect(x: 0, y: 0, width: 250, height: userInfoHeight)

        // Follow
        followButton.frame = CGRect(x: width - 120, y: 0, width: 120, height: userInfoHeight)

        // Image
        postImage.frame = CGRect(x: 0, y: userInfoHeight, width: width, height: width)

        // Favorite
        favoriteButton.frame = CGRect(x: 20, y: userInfoHeight + width + (menuHeight - 48) / 2, width: 48, height: 48)
        favoriteLabel.frame = CGRect(x: 68, y: userInfoHeight + width, width: 40, height: menuHeight)

        // Comment
        commentButton.frame = CGRect(x: 112, y: userInfoHeight + width + (menuHeight - 48) / 2, width: 48, height: 48)
        commentLabel.frame = CGRect(x: 160, y: userInfoHeight + width, width: 40, height: menuHeight)

        // Menu
        menuButton.frame = CGRect(x: width - 60, y: userInfoHeight + width + (menuHeight - 48) / 2, width: 48, height: 48)

        // Date
        dateLabel.frame = CGRect(x: 20, y: userInfoHeight + width + menuHeight, width: 240, height: dateHeight)

        // Detail
        let textViewSize = getTextViewSize(viewWidth: frame.width)
        detailTextView.frame = CGRect(
            x: 20,
            y: userInfoHeight + width + menuHeight + dateHeight,
            width: textViewSize.width,
            height: textViewSize.height)

        // BottomLine
        bottomLine.frame = CGRect(
            x: 0,
            y: userInfoHeight + width + menuHeight + dateHeight + textViewSize.height + bottomMargin - 1,
            width: width,
            height: 0.5)
    }

    func getTextViewSize(viewWidth: CGFloat) -> CGSize {
        return detailTextView.sizeThatFits(CGSize(width: viewWidth - 40, height: 0))
    }

    func calcHeight(viewWidth: CGFloat) -> CGFloat {
        let textViewSize = getTextViewSize(viewWidth: viewWidth)
        return userInfoHeight + viewWidth + menuHeight + dateHeight + textViewSize.height + bottomMargin
    }

    // Featch FireBase
    func featchUser(uid: String) {
        featchUserName(uid: uid)
        featchUserIcon(uid: uid)
    }

    func featchUserName(uid: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("user").document(String(uid))
        docRef.getDocument { (document, _) in
            guard let document = document, document.exists else {
                self.userInfoButton.userName.text = "ななしさん"
                return
            }
            guard let data = document.data() else {
                self.userInfoButton.userName.text = "ななしさん"
                return
            }
            guard let name = data["name"] as? String else {
                self.userInfoButton.userName.text = "ななしさん"
                return
            }
            self.userInfoButton.userName.text = name
        }
    }

    func featchUserIcon(uid: String) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child("user/" + String(uid) + "/icon.png")
        userInfoButton.userIcon.sd_setImage(with: reference, placeholderImage: UIImage(named: "common-icon-default"))
    }
}
