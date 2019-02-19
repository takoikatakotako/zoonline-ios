import UIKit

class FullLoadingView: UIView {

    var indicator: UIActivityIndicatorView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

        indicator = UIActivityIndicatorView()
        indicator.frame.size = CGSize(width: 80, height: 80)
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        indicator.startAnimating()
        self.addSubview(indicator)
    }

    override func layoutSubviews() {
        indicator.center = self.center
    }
}
