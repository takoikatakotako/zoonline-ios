import UIKit

class TagListTableViewCell: UITableViewCell {

    var tagLabel: UILabel!
    var deleateBtn: UIButton!
    var removeImg: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = UITableViewCell.SelectionStyle.none
        layoutMargins = UIEdgeInsets.zero

        tagLabel = UILabel()
        tagLabel.textAlignment = NSTextAlignment.center
        tagLabel.textColor = UIColor.white
        tagLabel.font = UIFont.boldSystemFont(ofSize: 18)
        tagLabel.backgroundColor = UIColor(named: "main")
        contentView.addSubview(tagLabel)

        removeImg = UIImageView()
        removeImg.image = UIImage(named: "remove")

        deleateBtn = UIButton()
        deleateBtn.addSubview(removeImg)
        contentView.addSubview(deleateBtn)
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
        let btnSize: CGFloat = 24

        // add # to top
        tagLabel.text = "#\(tagLabel.text!)"

        // calc tag label size
        let rect = tagLabel.sizeThatFits(CGSize.zero)

        tagLabel.frame = CGRect(x: 0, y: (height - rect.height) / 2, width: rect.width + 8, height: rect.height)
        deleateBtn.frame = CGRect(x: width - height, y: 0, width: height, height: height)
        removeImg.frame = CGRect(x: (height - btnSize) / 2, y: (height - btnSize) / 2, width: btnSize, height: btnSize)
    }
}
