import UIKit

class PostImageTableViewCell: UITableViewCell {

    var backgroundImageView: UIImageView!
    var postImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundImageView = UIImageView()
        backgroundImageView.isUserInteractionEnabled = false
        backgroundImageView.image = UIImage(named: "photoimage")    // width: 1242, height: 767
        contentView.addSubview(backgroundImageView)

        postImageView = UIImageView()
        postImageView.isUserInteractionEnabled = false
        postImageView.contentMode = .scaleAspectFill
        contentView.addSubview(postImageView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.frame = self.frame
        postImageView.frame = self.frame
    }
}

