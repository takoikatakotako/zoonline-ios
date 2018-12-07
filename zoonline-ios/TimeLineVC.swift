import UIKit
import SCLAlertView

class TimeLineVC: UIViewController {
    
    //width,height
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    private var statusBarHeight: CGFloat!
    private var navigationBarHeight: CGFloat!
    private var tabBarHeight: CGFloat!
    
    
    private var pageMenuHeight: CGFloat!
    private var contentsViewHeight: CGFloat!

    
    //var pageMenu : CAPSPageMenu?

    // MARK: 未ログイン関係の処理
    
    // MARK: setLoginView
    func setLoginView()  {
        

    }
    
    //ログインボタンが押されたら呼ばれます
    func loginBtnClicked(sender: UIButton){
        
        let loginView: LoginViewController = LoginViewController()
        self.present(loginView, animated: true, completion: nil)
    }
    
    //登録ボタンが押されたら呼ばれます
    func resistBtnClicked(sender: UIButton){
        
        let resistView: NewResistViewController = NewResistViewController()
        self.present(resistView, animated: true, completion: nil)
    }

    */
}
