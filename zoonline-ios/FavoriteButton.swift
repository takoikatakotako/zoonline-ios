import UIKit

class FavoriteButton: UIButton {

    var isFovorited: Bool?
    var favoriteIcon: UIImageView!
    var favoriteLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Favorite
        favoriteIcon = UIImageView()
        favoriteIcon.image = UIImage(named: "post-detail-fav-off")
        addSubview(favoriteIcon)

        favoriteLabel = UILabel()
        favoriteLabel.textColor = UIColor(named: "textColorGray")
        favoriteLabel.font = UIFont.boldSystemFont(ofSize: 24)
        favoriteLabel.text = "--"
        addSubview(favoriteLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        let width = frame.width
        let height = frame.height
        let iconSize = CGSize(width: 30, height: 30)

        favoriteIcon.frame = CGRect(x: 20, y: (height - iconSize.height) / 2, width: iconSize.width, height: iconSize.height)
        favoriteLabel.frame = CGRect(x: 60, y: 0, width: width, height: height)
    }

    func setFavorite() {
        isFovorited = true
        favoriteIcon.image = UIImage(named: "post-detail-fav-on")
        favoriteLabel.textColor = UIColor(named: "postDetailFavPink")
    }

    func setUnFavorite() {
        isFovorited = false
        favoriteIcon.image = UIImage(named: "post-detail-fav-off")
        favoriteLabel.textColor = UIColor(named: "textColorGray")
    }
}
