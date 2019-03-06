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
    var favoriteButton: FavoriteButton!

    // Comment
    var commentButton: CommentButton!

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
        userInfoButton = UserInfoButton(uid: post.uid)
        addSubview(userInfoButton)

        // Follow Info
        followButton = FollowButton()
        addSubview(followButton)

        // Image
        postImage = UIImageView()
        postImage.image = UIImage(named: "sample-postImage")
        addSubview(postImage)

        // Favorite
        favoriteButton = FavoriteButton()
        addSubview(favoriteButton)

        // Comment
        commentButton = CommentButton()
        addSubview(commentButton)

        // Menu
        menuButton = UIButton()
        menuButton.setImage(UIImage(named: "post-detail-menu"), for: .normal)
        addSubview(menuButton)

        // Date
        dateLabel = UILabel()
        dateLabel.text = post.date
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

        // featch
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child("post/" + post.id + "/image.png")
        postImage.sd_setImage(with: reference, placeholderImage: UIImage(named: "no_img"))
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
        favoriteButton.frame = CGRect(x: 0, y: userInfoHeight + width, width: 100, height: menuHeight)

        // Comment
        commentButton.frame = CGRect(x: 100, y: userInfoHeight + width, width: 100, height: menuHeight)

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
}
