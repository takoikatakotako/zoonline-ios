import UIKit
import Firebase
import GoogleSignIn
import FirebaseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    var userDefaultsManager: UserDefaultsManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        //ナビゲーションバー
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.init(named: "main")
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes =  [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
        ]

        // タブバー
        UITabBar.appearance().tintColor = UIColor.init(named: "main")
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "textColorGray")
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().isTranslucent = false

        // Managers
       self.userDefaultsManager = UserDefaultsManager()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.makeKeyAndVisible()
        window?.rootViewController = makeControllers()
        return true
    }

    func makeControllers() -> UITabBarController {
        var viewControllers: [UIViewController] = []

        let firstViewController: FieldViewController? = FieldViewController()
        firstViewController?.tabBarItem = UITabBarItem(title: "ひろば", image: UIImage(named: "tab_field"), tag: 1)
        let firstNavigationController = UINavigationController(rootViewController: firstViewController!)
        viewControllers.append(firstNavigationController)

        let thirdViewController: MyPageViewController? = MyPageViewController()
        thirdViewController?.tabBarItem = UITabBarItem(title: "マイページ", image: UIImage(named: "tab_mypage"), tag: 2)
        let thirdNavigationController = UINavigationController(rootViewController: thirdViewController!)
        viewControllers.append(thirdNavigationController)

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(viewControllers, animated: false)
        return tabBarController
    }

    func switchViewController(viewController: UIViewController) {
        UIView.transition(with: self.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.window?.rootViewController = self.makeControllers()
            UIView.setAnimationsEnabled(oldState)
        }, completion: nil)
    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: [:])
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error)
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (_, error) in
            if let error = error {
                print(error)
                return
            }
            print(credential)
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
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

