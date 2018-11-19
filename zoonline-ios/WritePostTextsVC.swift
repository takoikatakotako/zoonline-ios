import UIKit

//MARK: step 1 Add Protocol here
protocol SetTextDelegate: class {
    
    func setTitle(str:String)
    func setComment(str:String)
}

class WritePostTextsVC: UIViewController,UITextViewDelegate {

    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    
    //segue
    var isTitle:Bool!
    var navTitle:String!
    var text:String!
    
    //viewParts
    private var textView: UITextView = UITextView()
    
    
    weak var delegate: SetTextDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        
        self.view.backgroundColor = UIColor.white
        
        setNavigationBar()
        setTextView()
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        
        if isTitle! {
            delegate?.setTitle(str: textView.text)
        }else{
            delegate?.setComment(str: textView.text)
        }
    }
    
    
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        //ナビゲーションコントローラーの色の変更
        self.navigationController?.navigationBar.barTintColor = UIColor.init(named: "main")
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        //「<戻る」を「<」のみにする
        navigationController!.navigationBar.topItem!.title = " "
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = navTitle
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel

        let rightNavBtn = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(doClose(sender:)))
        self.navigationItem.rightBarButtonItem = rightNavBtn
    }
    
    //投稿ボタンが押されたら呼ばれる
    @objc internal func doClose(sender: UIButton){
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func setTextView(){
    
        textView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        //textView.backgroundColor = UIColor.red
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.delegate = self
        textView.text = text
        self.view.addSubview(textView)
    }
    
    
    //テキストビューが変更された
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    // テキストビューにフォーカスが移った
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if textView.text == "タイトルをつけてみよう" ||  textView.text == "コメントを書いてみよう"{
            textView.text = ""
        }
        return true
    }
    
    // テキストビューからフォーカスが失われた
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {

        return true
    }
    
    
    

}
