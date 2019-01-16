import UIKit

class PostTagTableViewCell: UITableViewCell {

    var tagsAry: Array<String> = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        /*
        iconImageView.isUserInteractionEnabled = false
        iconImageView.image = UIImage(named:"tag_blue")
        self.contentView.addSubview(iconImageView)
        
        tagLabel.isUserInteractionEnabled = false
        tagLabel.font = UIFont.systemFont(ofSize: 14)
        tagLabel.textColor = UIColor.gray
        tagLabel.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(tagLabel)
 */
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

        //subViewから全てを削除する
        let subviews = self.contentView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }

        //アイコンのセット
        let iconImageView: UIImageView = UIImageView()
        iconImageView.frame =  CGRect(x: cellWidth*0.06, y: cellWidth*0.04, width: cellWidth*0.08, height: cellWidth*0.08)
        iconImageView.isUserInteractionEnabled = false
        iconImageView.image = UIImage(named: "tag_blue")
        self.contentView.addSubview(iconImageView)

        if tagsAry.count == 0 {
            let tagLabel: UILabel = UILabel()
            tagLabel.isUserInteractionEnabled = false
            tagLabel.font = UIFont.systemFont(ofSize: 14)
            tagLabel.textColor = UIColor.gray
            tagLabel.textAlignment = NSTextAlignment.left
            tagLabel.frame = CGRect(x: cellWidth*0.18, y: cellWidth*0.04, width: cellWidth*0.8, height: 0)
            tagLabel.text = "タグをつけてみよう"
            tagLabel.sizeToFit()
            self.contentView.addSubview(tagLabel)
        }else {
            var count: Int = 0
            let separatedHeight: CGFloat = cellHeight/CGFloat(tagsAry.count+1)
            for tag in tagsAry {

                let tagsLabel: UILabel = UILabel()
                tagsLabel.text = "#"+tag
                tagsLabel.font = UIFont.boldSystemFont(ofSize: 16)
                tagsLabel.backgroundColor = UIColor(named: "ff92ae")
                tagsLabel.textColor = UIColor.white
                tagsLabel.textAlignment = NSTextAlignment.center
                let labelRect: CGSize = UtilityLibrary.calcLabelSize(text: tagsLabel.text!, font: tagsLabel.font)
                tagsLabel.frame = CGRect(x: cellWidth*0.2, y: separatedHeight*(0.6+CGFloat(count)), width: labelRect.width+cellWidth*0.05, height: labelRect.height)
                self.contentView.addSubview(tagsLabel)
                count += 1
            }
        }
    }
}

