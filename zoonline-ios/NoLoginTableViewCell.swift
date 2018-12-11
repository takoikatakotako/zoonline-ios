import UIKit

class NoLoginTableViewCell: UITableViewCell {

    var loginBtn: UIButton!
    var newResisterBtn: UIButton!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //LoginBtn
        loginBtn = UIButton()
        loginBtn.setTitle("ログイン", for: UIControl.State.normal)
        loginBtn.backgroundColor = UIColor(named: "loginRegistSkyBlue")
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 4.0
        self.addSubview(loginBtn)

        //newResist
        newResisterBtn = UIButton()
        newResisterBtn.setTitle("アカウント登録", for: UIControl.State.normal)
        newResisterBtn.backgroundColor = UIColor(named: "accountRegistErrorPink")
        newResisterBtn.layer.masksToBounds = true
        newResisterBtn.layer.cornerRadius = 4.0
        self.addSubview(newResisterBtn)
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

        //LoginLabel
        let claimLoginLabel: UILabel = UILabel()
        claimLoginLabel.text = "投稿・タイムラインを利用する\nにはログインしてください"
        claimLoginLabel.numberOfLines = 0
        claimLoginLabel.frame = CGRect(x: 0, y: cellHeight*0.05, width: cellWidth, height: cellHeight*0.1)
        claimLoginLabel.textAlignment = NSTextAlignment.center
        self.addSubview(claimLoginLabel)

        //アイコン
        var loginCanDoView: UIImageView!
        loginCanDoView = UIImageView()
        loginCanDoView.image = UIImage(named: "login_can_do")
        loginCanDoView.contentMode = UIView.ContentMode.scaleAspectFit
        loginCanDoView.frame = CGRect(x: 0, y: cellHeight*0.2, width: cellWidth, height: cellHeight*0.4)
        self.addSubview(loginCanDoView)

        //LoginBtn
        loginBtn.frame = CGRect(x: cellWidth*0.1, y: cellHeight*0.65, width: cellWidth*0.8, height: cellHeight*0.1)

        //newResist
        newResisterBtn.frame = CGRect(x: cellWidth*0.1, y: cellHeight*0.8, width: cellWidth*0.8, height: cellHeight*0.1)
    }
}
