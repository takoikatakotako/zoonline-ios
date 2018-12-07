import UIKit

class SupportBtn: UIButton {
    
    class func getSupportKey(pageNum: Int)->String{
        
        switch pageNum {
        case 0:
            return "KEY_SUPPORT_Field"
        case 2:
            return "KEY_SUPPORT_TimeLine"
        case 3:
            return "KEY_SUPPORT_Post"
        case 4:
            return "KEY_SUPPORT_Zoo"
        case 5:
            return "KEY_SUPPORT_PostDetail"
        default:
            return "KEY_SUPPORT_Field"
        }
    }
    
    class func getSupportImgName(pageNum: Int)->String{
        
        switch pageNum {
        case 0:
            return "support_plaza"
        case 2:
            return "support_timeline"
        case 3:
            return "support_post"
        case 4:
            return "support_official"
        case 5:
            return "support_detail"
        default:
            return "support_plaza"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView?.contentMode = UIView.ContentMode.bottomRight
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
        self.backgroundColor = UIColor.clear
    }
}
