import UIKit

class PostTextsTableViewCell: UITableViewCell {

    var iconImageView: UIImageView = UIImageView()
    var postTextView: UITextView = UITextView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        iconImageView.isUserInteractionEnabled = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "title_logo")
        contentView.addSubview(iconImageView)

        postTextView.isUserInteractionEnabled = false
        postTextView.isEditable = false
        postTextView.font = UIFont.systemFont(ofSize: 18)
        postTextView.textColor = UIColor.gray
        contentView.addSubview(postTextView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let width = self.frame.width
        let height = self.frame.height
        let sideMargin: CGFloat = 12
        let topMargin: CGFloat = 12
        let iconSize: CGFloat = 32

        iconImageView.frame = CGRect(x: sideMargin, y: topMargin, width: iconSize, height: iconSize)
        postTextView.frame = CGRect(x: sideMargin * 2 + iconSize, y: topMargin, width: width - (sideMargin * 3 + iconSize), height: height - topMargin * 2)
    }
}
