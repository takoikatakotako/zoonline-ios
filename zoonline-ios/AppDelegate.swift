import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var networkManager: NetWorkManager?
    var userDefaultsManager: UserDefaultsManager?
    var tabBarController: UITabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //ステータスバー
        //UIApplication.shared.statusBarStyle = .lightContent

        //ナビゲーションバー
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.init(named: "main")
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes =  [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
        ]

        //タブバー
        UITabBar.appearance().tintColor = UIColor.init(named: "main")
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "textColorGray")
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().isTranslucent = false

        //Managers
        self.networkManager = NetWorkManager()
        self.userDefaultsManager = UserDefaultsManager()

        // ページを格納する配列
        var viewControllers: [UIViewController] = []

        let firstViewController: FieldViewController? = FieldViewController()
        firstViewController?.tabBarItem = UITabBarItem(title: "ひろば", image: UIImage(named: "tab_field"), tag: 1)
        let firstNavigationController = UINavigationController(rootViewController: firstViewController!)
        viewControllers.append(firstNavigationController)

        // let secondViewController: TimeLineVC? = TimeLineVC()
        // secondViewController?.tabBarItem = UITabBarItem(title: "タイムライン", image: UIImage(named: "tab_timeline"), tag: 2)
        // let secondNavigationController = UINavigationController(rootViewController: secondViewController!)
        // viewControllers.append(secondNavigationController)

        let thirdViewController: MyPageViewController? = MyPageViewController()
        thirdViewController?.tabBarItem = UITabBarItem(title: "マイページ", image: UIImage(named: "tab_mypage"), tag: 2)
        let thirdNavigationController = UINavigationController(rootViewController: thirdViewController!)
        viewControllers.append(thirdNavigationController)

        tabBarController = UITabBarController()
        tabBarController?.setViewControllers(viewControllers, animated: false)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.makeKeyAndVisible()
        window?.rootViewController = tabBarController

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

