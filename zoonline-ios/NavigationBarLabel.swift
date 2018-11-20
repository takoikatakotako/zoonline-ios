import UIKit

class NavigationBarLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.white
        self.font = UIFont.boldSystemFont(ofSize: 18)
    }
}
