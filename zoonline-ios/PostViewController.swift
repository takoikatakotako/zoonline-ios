import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView

//class PostViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SetTextDelegate,SetTagsDelegate{
    
class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //width, height


    //views
    private var postTableView: UITableView!
    var myImagePicker: UIImagePickerController!
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()

    //datas
    public var postImage:UIImage! = UIImage(named:"photoimage")
    public var postImageWidth:CGFloat! = 100
    public var postImageHeight:CGFloat! = 62
    public var titleStr: String! = "タイトルをつけてみよう"
    public var commentStr: String! = "コメントを書いてみよう"
    var tagsAry:Array<String> = []
    

    //サポートボタン
    let supportBtn:UIButton = UIButton()
    
    //投稿フラグ
    var isSelectedImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setNavigationBar()
        setTableView()
        
    }
    
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        self.navigationItem.rightBarButtonItem = nil
        
        
        if UtilityLibrary.isLogin() {
            
            //バーの右側に設置するボタンの作成
            let rightNavBtn = UIBarButtonItem()
            rightNavBtn.image = UIImage(named:"submit_nav_btn")!
            rightNavBtn.action = #selector(postBarBtnClicked(sender:))
            rightNavBtn.target = self
            self.navigationItem.rightBarButtonItem = rightNavBtn
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let didSupport:Bool = (appDelegate.userDefaultsManager?.userDefaults.bool(forKey: "KEY_SUPPORT_Post"))!
            if !didSupport {
                setSupportBtn()
            }
        }else{
            //
            
        }
        self.postTableView.reloadData()
 
 
    }
 */
    
    
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバー
    func setNavigationBar() {
        
        let rightNavBtn = UIBarButtonItem()
        rightNavBtn.image = UIImage(named:"submit_nav_btn")!
        //rightNavBtn.action = #selector(postBarBtnClicked(sender:))
        //rightNavBtn.target = self
        self.navigationItem.rightBarButtonItem = rightNavBtn
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "投稿"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
    }
    
    //TableViewの設置
    func setTableView(){
        postTableView = UITableView()
        postTableView.frame = view.frame
        postTableView.dataSource = self
        postTableView.delegate = self
        postTableView.separatorStyle = .none
        postTableView.backgroundColor = UIColor(named: "mypageArrowGray")
        postTableView.separatorStyle = .none

        postTableView.register(PostImageTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostImageTableViewCell.self))
        postTableView.register(PostSpaceTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostSpaceTableViewCell.self))
        postTableView.register(PostTextsTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostTextsTableViewCell.self))
        postTableView.register(PostTagTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostTagTableViewCell.self))
        postTableView.register(NoLoginTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(NoLoginTableViewCell.self))
        postTableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        UITableView.appearance().layoutMargins = UIEdgeInsets.zero
        UITableViewCell.appearance().layoutMargins = UIEdgeInsets.zero
        self.view.addSubview(postTableView)
    }
    
    // MARK: くるくるの生成
    func setActivityIndicator(){
        /*
        indicator.frame = CGRect(x: viewWidth*0.35, y: viewWidth*0.5, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        indicator.color = UIColor.init(named: "main")
        self.view.bringSubviewToFront(indicator)
        self.view.addSubview(indicator)
         */
    }
    
    func setSupportBtn() {
        //サポート
        /*
        supportBtn.frame = CGRect(x: 0, y: 0, width: viewWidth, height: self.tableViewHeight)
        supportBtn.setImage(UIImage(named:"support_post"), for: UIControl.State.normal)
        supportBtn.imageView?.contentMode = UIView.ContentMode.bottomRight
        supportBtn.contentHorizontalAlignment = .fill
        supportBtn.contentVerticalAlignment = .fill
        supportBtn.backgroundColor = UIColor.clear
        supportBtn.addTarget(self, action: #selector(supportBtnClicked(sender:)), for:.touchUpInside)
        self.view.addSubview(supportBtn)
         */
    }
    
    //MARK: ButtonActions
    @objc func supportBtnClicked(sender: UIButton){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(true, forKey: "KEY_SUPPORT_Post")
        supportBtn.removeFromSuperview()
    }
    
    //投稿ボタンが押されたら呼ばれる
    @objc internal func postBarBtnClicked(sender: UIButton){
        
        if !isSelectedImage {
            SCLAlertView().showInfo("エラー", subTitle: "画像が選択されていません。")
            return
        }
        
        if titleStr == "タイトルをつけてみよう" {
            SCLAlertView().showInfo("エラー", subTitle: "タイトルを入力して下さい。")
            return
        }
        
        if titleStr.isEmpty {
            SCLAlertView().showInfo("エラー", subTitle: "タイトルが空です。")
            return
        }

        if commentStr == "コメントを書いてみよう" {
            SCLAlertView().showInfo("エラー", subTitle: "タイトルを入力して下さい。")
            return
        }
        
        if commentStr.isEmpty {
            SCLAlertView().showInfo("エラー", subTitle: "コメントを入力してください。")
            return
        }
        
        doImageUpload()
        self.indicator.startAnimating()
    }
    
    
    func doImageUpload() {
        
        let userID:String = UtilityLibrary.getUserID()
        let imageData = postImage.pngData()!
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "picture", fileName: "file_name.png", mimeType: "image/png")
            multipartFormData.append(userID.data(using: String.Encoding.utf8)!, withName: "user_id")
        }, to:EveryZooAPI.getUploadPicture(),  headers: UtilityLibrary.getAPIAccessHeader())
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    //print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.request ?? "response.request")  // original URL request
                    print(response.response ?? "response.response") // URL response
                    print(response.data ?? "response.data")     // server data
                    print(response.result)   // result of response serialization
                    
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                        let json:JSON = JSON(response.result.value ?? kill)
                        print(json)
                        
                        
                        if json["is_success"].boolValue  {
                            let pic_id:String = json["picture"]["pic_id"].stringValue
                            
                            self.doPost(pic_id: pic_id)
                        }
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    func doPost(pic_id:String) {
        
        let parameters: Parameters = [
            "title": titleStr,
            "caption": commentStr,
            "pic_id":pic_id,
            "tags":tagsAry
        ]
        
        Alamofire.request(API_URL+"/v0/posts", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON{ response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
                
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                self.indicator.stopAnimating()
                
                if json["is_success"].boolValue {
                    SCLAlertView().showSuccess("投稿完了", subTitle: "投稿が完了しました。")
                }else{
                    SCLAlertView().showSuccess("投稿失敗", subTitle: "投稿に失敗しました。不明なエラーです。")
                }
                
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
                SCLAlertView().showError("投稿失敗", subTitle: "投稿に失敗しました。通信状況を確認してください。")
            }
        }
    }
    
    
    //MARK: テーブルビューのセルの高さを計算する
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        if !UtilityLibrary.isLogin() {
            return tableViewHeight
        }
        
        if indexPath.row == 0 {
            //投稿画像のView
            return viewWidth*(postImageHeight/postImageWidth)
        }else if indexPath.row == 2{
            //タイトルのセル
            return viewWidth*0.15
        }else if indexPath.row == 4{
            //コメントのセル
            //コメントの高さを計算して、規定の値と比較。高い方を返す
            var testHeight:CGFloat = UtilityLibrary.calcTextViewHeight(text: commentStr, width: viewWidth*0.8, font: UIFont.systemFont(ofSize: 14))
            testHeight += viewWidth*0.03
            if testHeight >  viewWidth*0.3{
                return testHeight
            }
            return viewWidth*0.3
        }else if indexPath.row == 6{
            //タグのセル
            
            //タグに何も入っていないときは最初の規定値を返す
            if tagsAry.count == 0 {
                return viewWidth*0.3
            }
            
            //サイズの計算
            let rect:CGSize = UtilityLibrary.calcLabelSize(text: "#SampleTag", font: UIFont.boldSystemFont(ofSize: 16))

            //タグ自体は80%、そして上下に0.5個分のマージン
            let tagCellHeoght:CGFloat = rect.height*CGFloat(tagsAry.count+1)*(10/8)
            return tagCellHeoght
            
        }else if indexPath.row == 8{
            //サブミッションポリシーのボタン
            return viewWidth*0.15
        }
        
        else{
            //スペース部分
            return viewWidth*0.04
        }
    }
    */
    
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !UtilityLibrary.isLogin() {
            return 1
        }
        
        //通常は8
        return 8
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        

        
        if indexPath.row == 0 {
            //画像選択View
            let cell:PostImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostImageTableViewCell.self), for: indexPath) as! PostImageTableViewCell
            cell.postImageView.image = postImage
            return cell
        }else if indexPath.row == 2 {
            //画像選択View
            let cell:PostTextsTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostTextsTableViewCell.self), for: indexPath) as! PostTextsTableViewCell
            cell.iconImageView.image = UIImage(named:"title_logo")
            cell.postTextView.text = titleStr
            return cell
        }else if indexPath.row == 4 {
            //画像選択View
            let cell:PostTextsTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostTextsTableViewCell.self), for: indexPath) as! PostTextsTableViewCell
            cell.iconImageView.image = UIImage(named:"comment_blue")
            cell.postTextView.text = commentStr
            return cell
        }else if indexPath.row == 6 {
            //タグの選択View
            let cell:PostTagTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostTagTableViewCell.self), for: indexPath) as! PostTagTableViewCell
            cell.tagsAry = tagsAry

            return cell
        }else{
        
            //スペーサーView
            let cell:PostSpaceTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostSpaceTableViewCell.self), for: indexPath) as! PostSpaceTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        
        
        /*
        if !UtilityLibrary.isLogin() {
            return
        }
        
        //画面遷移、投稿詳細画面へ
        if indexPath.row == 0{
            
            // インスタンス生成
            myImagePicker = UIImagePickerController()
            myImagePicker.delegate = self
            myImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            myImagePicker.navigationBar.barTintColor = UIColor.init(named: "main")
            myImagePicker.navigationBar.tintColor = UIColor.white
            myImagePicker.navigationBar.isTranslucent = false
            //myImagePicker.allowsEditing = false
            self.present(myImagePicker, animated: true, completion: nil)
            
        }else if indexPath.row == 2 {
            let writePosTextsVC:WritePostTextsVC = WritePostTextsVC()
            writePosTextsVC.text = titleStr
            writePosTextsVC.isTitle = true
            writePosTextsVC.navTitle = "タイトル"
            writePosTextsVC.delegate = self
            self.navigationController?.pushViewController(writePosTextsVC, animated: true)
        }else if indexPath.row == 4 {
            let writePosTextsVC:WritePostTextsVC = WritePostTextsVC()
            writePosTextsVC.text = commentStr
            writePosTextsVC.isTitle = false
            writePosTextsVC.navTitle = "コメント"
            writePosTextsVC.delegate = self
            self.navigationController?.pushViewController(writePosTextsVC, animated: true)
        }else if indexPath.row == 6{
            let SetPostTagsVC:SetPostTagsViewController = SetPostTagsViewController()
            SetPostTagsVC.tagsAry = self.tagsAry
            SetPostTagsVC.delegate = self
            self.navigationController?.pushViewController(SetPostTagsVC, animated: true)
        }
 
 */
    }
    
    
    /*
    func setTitle(str:String){
        titleStr = str
    }
    
    func setComment(str:String) {
        commentStr = str
    }
    
    func setTags(ary:Array<String>){
        tagsAry = ary
    }
    
    //画像が選択された時に呼ばれる.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            
            postImage = image
            postImageWidth = postImage.size.width
            postImageHeight = postImage.size.height
            postTableView.reloadData()
            
            isSelectedImage = true

        } else{
            print("Error:Class name : \(NSStringFromClass(type(of: self))) ")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //画像選択がキャンセルされた時に呼ばれる.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //Mark: 未ログイン関係の処理
    
    //ログインボタンが押されたら呼ばれます
    @objc func loginBtnClicked(sender: UIButton){
        
        let loginView:LoginViewController = LoginViewController()
        loginView.statusBarHeight = self.statusBarHeight
        loginView.navigationBarHeight = self.navigationBarHeight
        self.present(loginView, animated: true, completion: nil)
    }
    
    //登録ボタンが押されたら呼ばれます
    @objc func resistBtnClicked(sender: UIButton){
        
        let resistView:NewResistViewController = NewResistViewController()
        resistView.statusBarHeight = self.statusBarHeight
        resistView.navigationBarHeight = self.navigationBarHeight
        self.present(resistView, animated: true, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
 
 */
}
