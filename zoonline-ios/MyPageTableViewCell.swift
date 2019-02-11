import UIKit

class MyPageTableViewCell: UITableViewCell {

    var thumbnailImgView: UIImageView! = UIImageView()
    var textCellLabel: UILabel! = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(thumbnailImgView)
        contentView.addSubview(textCellLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let cellWidth: CGFloat = self.frame.width
        let cellHeight: CGFloat = self.frame.height

        // ThumbnailUmg
        thumbnailImgView.frame = CGRect(x: cellWidth*0.05, y: cellHeight*0.15, width: cellHeight*0.7, height: cellHeight*0.7)
        thumbnailImgView.layer.cornerRadius = cellHeight*0.7/2
        thumbnailImgView.layer.masksToBounds = true

        // TitleText
        textCellLabel.frame = CGRect(x: cellWidth*0.2, y: cellHeight*0.1, width: cellWidth*0.6, height: cellHeight*0.8)
    }
}
