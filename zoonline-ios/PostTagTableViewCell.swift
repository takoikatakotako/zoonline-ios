import UIKit

class PostTagTableViewCell: UITableViewCell {

    var tagsAry: [String] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let width = frame.width
        let height = frame.height
        let sideMargin: CGFloat = 12
        let topMargin: CGFloat = 12
        let iconSize: CGFloat = 32

        // subViewから全てを削除する
        let subviews = self.contentView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }

        // アイコンのセット
        let iconImageView: UIImageView = UIImageView()
        iconImageView.frame = CGRect(x: sideMargin, y: topMargin, width: iconSize, height: iconSize)
        iconImageView.isUserInteractionEnabled = false
        iconImageView.image = UIImage(named: "tag_blue")
        contentView.addSubview(iconImageView)

        if tagsAry.count == 0 {
            let tagLabel: UILabel = UILabel()
            tagLabel.isUserInteractionEnabled = false
            tagLabel.font = UIFont.systemFont(ofSize: 14)
            tagLabel.textColor = UIColor.gray
            tagLabel.textAlignment = NSTextAlignment.left
            tagLabel.frame = CGRect(x: width * 0.18, y: width * 0.04, width: width * 0.8, height: 0)
            tagLabel.text = "タグをつけてみよう"
            tagLabel.sizeToFit()
            self.contentView.addSubview(tagLabel)
        } else {
            var count: Int = 0
            let separatedHeight: CGFloat = height / CGFloat(tagsAry.count + 1)
            for tag in tagsAry {

                let tagsLabel: UILabel = UILabel()
                tagsLabel.text = "#" + tag
                tagsLabel.font = UIFont.boldSystemFont(ofSize: 16)
                tagsLabel.backgroundColor = UIColor(named: "ff92ae")
                tagsLabel.textColor = UIColor.white
                tagsLabel.textAlignment = NSTextAlignment.center
                let labelRect: CGSize = UtilityLibrary.calcLabelSize(text: tagsLabel.text!, font: tagsLabel.font)
                tagsLabel.frame = CGRect(x: width * 0.2, y: separatedHeight * (0.6 + CGFloat(count)), width: labelRect.width + width * 0.05, height: labelRect.height)
                self.contentView.addSubview(tagsLabel)
                count += 1
            }
        }
    }
}
