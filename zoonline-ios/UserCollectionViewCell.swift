import UIKit

class UserCollectionViewCell: UICollectionViewCell {

    var icomImageView: UIImageView!
    var userLabel: UILabel!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let cellWidth: CGFloat = frame.width
        let cellHeight: CGFloat = frame.height

        //iconImage
        icomImageView = UIImageView()
        icomImageView!.frame = CGRect(x: cellWidth*0.2, y: cellHeight*0.1, width: cellWidth*0.6, height: cellHeight*0.6)
        icomImageView!.image = UIImage(named: "common-icon-default")
        icomImageView.clipsToBounds = true
        icomImageView.layer.cornerRadius = cellWidth*0.6*0.5
        self.contentView.addSubview(icomImageView!)

        // UILabelを生成.
        userLabel = UILabel(frame: CGRect(x: cellWidth*0.1, y: cellHeight*0.7, width: cellWidth*0.8, height: cellHeight*0.3))
        userLabel?.backgroundColor = UIColor.white
        userLabel?.textAlignment = NSTextAlignment.center
        userLabel?.font = UIFont.systemFont(ofSize: 12)
        userLabel?.numberOfLines = 0
        userLabel?.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(userLabel!)
    }
}
