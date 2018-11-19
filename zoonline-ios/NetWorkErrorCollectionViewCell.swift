import UIKit

class NetWorkErrorCollectionViewCell: UICollectionViewCell {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cellWidth:CGFloat = self.frame.width
        let cellHeight:CGFloat = self.frame.height
        
        let errorLabel = UILabel()
        errorLabel.text = "ネットワークエラー"
        errorLabel.frame = CGRect(x: 0, y: cellHeight*0.05, width: cellWidth, height: cellHeight*0.1)
        errorLabel.textColor = UIColor(named: "darkPink")
        errorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        errorLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(errorLabel)
        
        let messageLabel = UILabel()
        messageLabel.text = "通信を確認してください"
        messageLabel.frame = CGRect(x: 0, y: cellHeight*0.15, width: cellWidth, height: cellHeight*0.1)
        messageLabel.textColor = UIColor.black
        messageLabel.font = UIFont.systemFont(ofSize: 20)
        messageLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(messageLabel)
        
        let penguinImgView = UIImageView()
        penguinImgView.image = UIImage(named:"chara_penpen")
        penguinImgView.frame = CGRect(x: 0, y: cellHeight*0.3, width: cellWidth, height: cellHeight*0.6)
        penguinImgView.contentMode = UIView.ContentMode.scaleAspectFit
        self.contentView.addSubview(penguinImgView)
    }
}
