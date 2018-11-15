import UIKit

class FieldCollectionViewCell: UICollectionViewCell {
    var thumbnailImgView : UIImageView?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // thumbnailImgを生成.
        thumbnailImgView = UIImageView()
        self.contentMode = UIViewContentMode.scaleAspectFill
        self.backgroundView = self.thumbnailImgView
    }
}
