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

    /*
    //var pageMenu : CAPSPageMenu?

    
    //view parts
    private var postDetailTableView: UITableView!
    

     override func viewDidLoad() {
        super.viewDidLoad()

        //画面横サイズを取得
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        
        pageMenuHeight = navigationBarHeight
        contentsViewHeight = viewHeight
        
        //Viewにパーツを追加
        setNavigationBarBar()
        
        if !UtilityLibrary.isLogin() {

            setPageMenu()
            
        }else{
            setLoginView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //postDetailTableView.reloadData()
    }
    

    func setNavigationBarBar(){
        
        //UINavigationBarの位置とサイズを指定
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: statusBarHeight, width: viewWidth, height: navigationBarHeight)
        UINavigationBar.appearance().tintColor = UIColor.white
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.title = "タイムライン"
    }
    
    
    func setPageMenu() {
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        let vc0:UIViewController = UIViewController()
        vc0.title = "すべて"
        vc0.view.backgroundColor = UIColor.red
        controllerArray.append(vc0)

        let vc1:UIViewController = UIViewController()
        vc1.title = "ユーザー"
        vc1.view.backgroundColor = UIColor.green
        controllerArray.append(vc1)
        
        let vc2:UIViewController = UIViewController()
        vc2.title = "タグ"
        vc2.view.backgroundColor = UIColor.blue
        controllerArray.append(vc2)
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.white),
            .menuItemSeparatorWidth(4),
            .menuHeight(pageMenuHeight),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .bottomMenuHairlineColor(UIColor.blue),
            .selectionIndicatorColor(UIColor.init(named: "main")),
            .selectedMenuItemLabelColor(UIColor.init(named: "main")),
            .menuItemFont(UIFont.boldSystemFont(ofSize: 16)),
            .unselectedMenuItemLabelColor(UIColor.gray)
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 0, width: viewWidth, height: contentsViewHeight), pageMenuOptions: parameters)
        pageMenu!.view.backgroundColor = UIColor.white
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)
    }
    
    
    func setLoginView()  {
        

    }
    
    //ログインボタンが押されたら呼ばれます
    func loginBtnClicked(sender: UIButton){
        
        let loginView:LoginViewController = LoginViewController()
        self.present(loginView, animated: true, completion: nil)
    }
    
    //登録ボタンが押されたら呼ばれます
    func resistBtnClicked(sender: UIButton){
        
        let resistView:NewResistViewController = NewResistViewController()
        self.present(resistView, animated: true, completion: nil)
    }

    */
}
