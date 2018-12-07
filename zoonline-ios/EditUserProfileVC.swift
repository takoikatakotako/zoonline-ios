import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView

class EditUserProfileVC: UIViewController {
    
    //width, height
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    private var statusBarHeight: CGFloat!
    private var navigationBarHeight: CGFloat!
    private var tabBarHeight: CGFloat!
    private var textViewHeight: CGFloat!

    
    private var userProfileTexView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        textViewHeight = viewHeight - (statusBarHeight + navigationBarHeight + tabBarHeight)
        
        self.view.backgroundColor = UIColor.white
        
        setNavigationBar()
        setTextView()
        
        let myProfile = UtilityLibrary.getUserProfile()
        if myProfile.isEmpty {
            userProfileTexView.text = "あなたのプロフィールを記入してください。"
        }else{
            userProfileTexView.text = myProfile
        }
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(named: "main")
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel: UILabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "プロフィールの変更"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        
        let rightNavBtn = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(doChageProfile(sender:)))
        self.navigationItem.rightBarButtonItem = rightNavBtn
    }
    
    //プロフィール変更ボタンが押されたら
    @objc internal func doChageProfile(sender: UIButton){
        
        if (userProfileTexView.text?.isEmpty)! {
            SCLAlertView().showInfo("エラー", subTitle: "プロフィールの入力が必要です。")
            return
        }
        
        let parameters: Parameters = [
            "profile": userProfileTexView.text
        ]
        
        Alamofire.request(API_URL+"v0/users/"+UtilityLibrary.getUserID(), method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON{response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
                let json: JSON = JSON(response.result.value ?? kill)
                print(json)
                SCLAlertView().showInfo("プロフィール更新", subTitle: "プロフィールを更新しました。")
                _ = self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func setTextView(){
        
        // TextView生成する.
        userProfileTexView = UITextView()
        userProfileTexView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: textViewHeight)
        userProfileTexView.text = ""
        userProfileTexView.font = UIFont.systemFont(ofSize: 20.0)
        userProfileTexView.textColor = UIColor.black
        self.view.addSubview(userProfileTexView)
        
        //キーボードは出しておく
        userProfileTexView.becomeFirstResponder()
    }
    

}
