import UIKit

class MyPageUserCellBtn: UIButton {
    
    let iconImgView:UIImageView = UIImageView()
    let userNameLabel:UILabel = UILabel()
    let userMailAdressLabel:UILabel = UILabel()

    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)!
    }

    
    private func commonInit() {
        
        let viewWidth:CGFloat = self.frame.size.width
        let viewHeight:CGFloat = self.frame.size.height

        //アイコン
        iconImgView.image = UIImage(named:"common-icon-default")
        iconImgView.frame = CGRect(x: viewHeight*0.1, y: viewHeight*0.1, width: viewHeight*0.8, height: viewHeight*0.8)
        iconImgView.backgroundColor = UIColor.white
        iconImgView.layer.cornerRadius = viewHeight*0.8/2
        iconImgView.layer.masksToBounds = true
        self.addSubview(iconImgView)
        
        //ユーザーラベル
        userNameLabel.text = "未ログイン"
        userNameLabel.font = UIFont.systemFont(ofSize: 24)
        userNameLabel.frame = CGRect(x: viewHeight*1.1, y: viewHeight*0.2, width: viewWidth*0.6, height: viewHeight*0.4)
        self.addSubview(userNameLabel)
        
        //メールアドレス
        userMailAdressLabel.text = "ログインしてください"
        userMailAdressLabel.font = UIFont.systemFont(ofSize: 14)
        userMailAdressLabel.frame = CGRect(x: viewHeight*1.1, y: viewHeight*0.6, width: viewWidth*0.6, height: viewHeight*0.3)
        self.addSubview(userMailAdressLabel)
        
        //プロフィール画面の矢印
        let profielArrow:UIImageView = UIImageView()
        profielArrow.image = UIImage(named:"arrow_rignt")
        profielArrow.frame = CGRect(x: viewWidth*0.9, y: viewHeight*0.4, width: viewWidth*0.03, height: viewHeight*0.2)
        self.addSubview(profielArrow)
    }
}
