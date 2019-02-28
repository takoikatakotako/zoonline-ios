import UIKit

class PictureExpandViewController: UIViewController, UIScrollViewDelegate {

    //width, height
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    private var scrollViewHeight: CGFloat!
    private var imageScrollView: UIScrollView!
    private var postImgView: UIImageView!

    var statusBarHeight: CGFloat!
    var navigationBarHeight: CGFloat!
    var image: UIImage!
    var navigationTitle: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        scrollViewHeight = viewHeight - (statusBarHeight+navigationBarHeight)

        view.backgroundColor = UIColor.white

        setNavigationBar()
        setImageScrollView()
    }

    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {

        //ステータスバー部分の覆い
        let aadView: UIView = UIView()
        aadView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: statusBarHeight*2)
        aadView.backgroundColor = UIColor.init(named: "main")
        view.addSubview(aadView)

        //ナビゲーションコントローラーの色の変更
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: statusBarHeight, width: viewWidth, height: navigationBarHeight)
        navBar.barTintColor = UIColor.init(named: "main")
        navBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white

        //ナビゲーションアイテムを作成
        let navItems = UINavigationItem()

        //バーの左側に設置するボタンの作成
        let leftNavBtn =  UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(doClose(sender:)))
        navItems.leftBarButtonItem = leftNavBtn
        view.addSubview(navBar)
    }

    func setImageScrollView() {
        imageScrollView = UIScrollView()
        imageScrollView.frame = CGRect(x: 0, y: statusBarHeight+navigationBarHeight, width: self.view.frame.width, height: scrollViewHeight)
        self.imageScrollView.delegate = self
        imageScrollView.maximumZoomScale = 3.0
        imageScrollView.minimumZoomScale = 1.0
        self.view.addSubview(imageScrollView)

        postImgView = UIImageView()
        postImgView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: scrollViewHeight)
        postImgView.image = image
        postImgView.contentMode = UIView.ContentMode.scaleAspectFit
        imageScrollView.addSubview(postImgView)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.postImgView
    }

    @objc func doClose(sender: UIButton) {
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        dismiss(animated: true, completion: nil)
    }
}
