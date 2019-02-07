import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView

protocol SampleDelegate: class {
    func changeMyProfile(profile: String)
}

class EditUserProfileViewController: UIViewController {

    private var userProfileTexView: UITextView!

    //delegate
    weak var delegate: SampleDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        title = "プロフィール編集"

        // Navigation Bar
        let rightNavBtn = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(doChageProfile(sender:)))
        self.navigationItem.rightBarButtonItem = rightNavBtn

        // TextView生成する.
        userProfileTexView = UITextView()
        userProfileTexView.frame = view.frame
        userProfileTexView.text = ""
        userProfileTexView.font = UIFont.systemFont(ofSize: 20.0)
        userProfileTexView.textColor = UIColor.black
        view.addSubview(userProfileTexView)

        //キーボードは出しておく
        userProfileTexView.becomeFirstResponder()
        let myProfile = UtilityLibrary.getUserProfile()
        if myProfile.isEmpty {
            userProfileTexView.text = "あなたのプロフィールを記入してください。"
        }else {
            userProfileTexView.text = myProfile
        }
    }

    // MARK: - Viewにパーツの設置

    //プロフィール変更ボタンが押されたら
    @objc func doChageProfile(sender: UIButton) {
        if (userProfileTexView.text?.isEmpty)! {
            SCLAlertView().showInfo("エラー", subTitle: "プロフィールの入力が必要です。")
            return
        }
        delegate?.changeMyProfile(profile: userProfileTexView.text)
        self.navigationController?.popViewController(animated: true)

    }
}
