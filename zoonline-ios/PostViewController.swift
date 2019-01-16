import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView

//class PostViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SetTextDelegate,SetTagsDelegate{

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker: UIImagePickerController!

    //width, height

    //views
    private var postTableView: UITableView!
    var myImagePicker: UIImagePickerController!
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()

    //datas
    public var postImage: UIImage! = UIImage(named: "photoimage")
    public var postImageWidth: CGFloat! = 100
    public var postImageHeight: CGFloat! = 62
    public var titleStr: String! = "タイトルをつけてみよう"
    public var commentStr: String! = "コメントを書いてみよう"
    var tagsAry: [String] = []

    //サポートボタン
    let supportBtn: UIButton = UIButton()

    //投稿フラグ
    var isSelectedImage = false

    //
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "投稿する"

        // NavigationBar
        let rightNavBtn = UIBarButtonItem()
        rightNavBtn.image = UIImage(named: "submit_nav_btn")!
        navigationItem.rightBarButtonItem = rightNavBtn
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(dismissView))

        // TableView
        postTableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        postTableView.frame = view.frame
        postTableView.dataSource = self
        postTableView.delegate = self
        postTableView.backgroundColor = UIColor(named: "mypageArrowGray")
        // postTableView.separatorStyle = .none
        postTableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        postTableView.register(PostImageTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostImageTableViewCell.self))
        postTableView.register(PostTextsTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostTextsTableViewCell.self))
        postTableView.register(PostTagTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostTagTableViewCell.self))
        postTableView.register(NoLoginTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(NoLoginTableViewCell.self))
        postTableView.backgroundColor = .lightGray
        postTableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        // UITableView.appearance().layoutMargins = UIEdgeInsets.zero
        // UITableViewCell.appearance().layoutMargins = UIEdgeInsets.zero
        view.addSubview(postTableView)

        picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = true // Whether to make it possible to edit the size etc after selecting the image
        // set picker's navigationBar appearance
        picker.view.backgroundColor = .white
        picker.navigationBar.isTranslucent = false
        picker.navigationBar.barTintColor = .blue
        picker.navigationBar.tintColor = .white
        picker.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ] // Title color
    }

    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Viewにパーツの設置

    //TableViewの設置
    func setTableView() {

    }

    // MARK: くるくるの生成
    func setActivityIndicator() {
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

    // MARK: ButtonActions
    @objc func supportBtnClicked(sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userDefaultsManager?.userDefaults.set(true, forKey: "KEY_SUPPORT_Post")
        supportBtn.removeFromSuperview()
    }

    //投稿ボタンが押されたら呼ばれる
    @objc internal func postBarBtnClicked(sender: UIButton) {

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

        let userID: String = UtilityLibrary.getUserID()
        let imageData = postImage.pngData()!
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "picture", fileName: "file_name.png", mimeType: "image/png")
            multipartFormData.append(userID.data(using: String.Encoding.utf8)!, withName: "user_id")
        }, to: EveryZooAPI.getUploadPicture(), headers: UtilityLibrary.getAPIAccessHeader()) { (result) in
            switch result {
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { (_) in
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
                        let json: JSON = JSON(response.result.value ?? kill)
                        print(json)

                        if json["is_success"].boolValue {
                            let pic_id: String = json["picture"]["pic_id"].stringValue

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

    func doPost(pic_id: String) {

        let parameters: Parameters = [
            "title": titleStr,
            "caption": commentStr,
            "pic_id": pic_id,
            "tags": tagsAry
        ]

        Alamofire.request(API_URL+"/v0/posts", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON { response in

            switch response.result {
            case .success:
                print("Validation Successful")

                let json: JSON = JSON(response.result.value ?? kill)
                print(json)
                self.indicator.stopAnimating()

                if json["is_success"].boolValue {
                    SCLAlertView().showSuccess("投稿完了", subTitle: "投稿が完了しました。")
                }else {
                    SCLAlertView().showSuccess("投稿失敗", subTitle: "投稿に失敗しました。不明なエラーです。")
                }

            case .failure(let error):
                print(error)
                //テーブルの再読み込み
                SCLAlertView().showError("投稿失敗", subTitle: "投稿に失敗しました。通信状況を確認してください。")
            }
        }
    }

    // MARK: - TableView Delegate Methods
    // MARK: Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    // MARK: Headers
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    // MARK: Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if image == nil {
                let photoImage = UIImage(named: "photoimage")!.cgImage!
                let width = CGFloat(photoImage.width)
                let height = CGFloat(photoImage.height)
                return view.frame.width * (height / width)
            }
            let width = CGFloat(image.cgImage!.width)
            let height = CGFloat(image.cgImage!.height)
            return view.frame.width * (height / width)
        } else if indexPath.section == 1 {
            return 160
        } else {
            return 160
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: PostImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostImageTableViewCell.self), for: indexPath) as! PostImageTableViewCell
            if image != nil {
                cell.postImageView.image = image
            }
            return cell
        } else if indexPath.section == 1 {
            let cell: PostTextsTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostTextsTableViewCell.self), for: indexPath) as! PostTextsTableViewCell
            cell.iconImageView.image = UIImage(named: "title_logo")
            cell.postTextView.text = titleStr
            return cell
        } else {
            let cell: PostTagTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostTagTableViewCell.self), for: indexPath) as! PostTagTableViewCell
            cell.tagsAry = tagsAry
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        if indexPath.section == 0 {
            present(picker, animated: true, completion: nil)
        } else if indexPath.section == 1 {
            let writePosTextsVC: WritePostTextsVC = WritePostTextsVC()
            navigationController?.pushViewController(writePosTextsVC, animated: true)
        }

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

    // MARK: ImageVicker Delegate Methods
    // called when image picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = originalImage
        }
        postTableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

    // called when cancel select image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // close picker modal
        dismiss(animated: true, completion: nil)
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
