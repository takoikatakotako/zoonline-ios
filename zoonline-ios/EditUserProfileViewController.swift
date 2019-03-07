import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView

class EditUserProfileViewController: UIViewController {

    private var userProfileTexView: UITextView!

    var uid: String
    init(uid: String) {
        self.uid = uid
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "プロフィール編集"

        // Navigation Bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(doChageProfile(sender:)))

        // TextView生成する.
        userProfileTexView = UITextView()
        userProfileTexView.frame = view.frame
        userProfileTexView.text = ""
        userProfileTexView.font = UIFont.systemFont(ofSize: 20.0)
        userProfileTexView.textColor = UIColor.black
        view.addSubview(userProfileTexView)

        //キーボードは出しておく
        userProfileTexView.becomeFirstResponder()

        UserHandler.featchUser(uid: uid) { (user, error) in
            if let error = error {
                self.showMessageAlert(message: error.description)
                return
            }

            guard let profile = user?.profile else {
                self.userProfileTexView.text = "あなたのプロフィールを記入してください。"
                return
            }
            self.userProfileTexView.text = profile
        }
    }

    //プロフィール変更ボタンが押されたら
    @objc func doChageProfile(sender: UIButton) {
        guard let profile = userProfileTexView.text else {
            SCLAlertView().showInfo("エラー", subTitle: "プロフィールの入力が必要です。")
            return
        }

        UserHandler.setProfile(uid: uid, profile: profile, completion: { (error) in
            if let error = error {
                self.showMessageAlert(message: error.description)
            }
        })
        navigationController?.popViewController(animated: true)
    }
}
