import UIKit

class PostsCollectionView: UICollectionViewCell {
    var imageView: UIImageView!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let width: CGFloat = frame.width
        let height: CGFloat = frame.height
        let margin: CGFloat = 2
        //iconImage
        imageView = UIImageView()
        imageView.frame = CGRect(x: margin, y: margin, width: width - margin * 2, height: height - margin * 2)
        // imageView.frame = self.frame
        imageView.image = UIImage(named: "sample-postImage")
        imageView.clipsToBounds = true
        // imageView.layer.cornerRadius = 24
        addSubview(imageView)
    }
}
