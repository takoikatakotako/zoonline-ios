//
//  MyPageProfilelViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/05/18.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import SCLAlertView

class MyPageProfilelViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    var myProfielViewHeight:CGFloat!
    private var userConfigTableViewHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    
    var indicator: UIActivityIndicatorView!
    
    //プロフィール
    var icon:UIImageView = UIImageView()
    let nameLabel:UILabel = UILabel()
    let mailLabel:UILabel = UILabel()

    //テーブルビューインスタンス
    var userConfigTableView: UITableView!
    
    //表示するもの
    let changeUserInfoAry:Array<String> = ["プロフィールのプレビュー","","ユーザー名の変更","プロフィールの変更","メールアドレスの変更","パスワードの変更",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.LiginCushionLightGray()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        
        myProfielViewHeight = viewWidth*0.56
        userConfigTableViewHeight = viewHeight - (statusBarHeight+navigationBarHeight+myProfielViewHeight+tabBarHeight)
        
        setNavigationBar()
        setActivityIndicator()
        getUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        let defaultIcon = UIImage(named:"icon_default")
        if let url = URL(string: UtilityLibrary.getUserIconUrl()){
            icon.af_setImage(withURL: url, placeholderImage: defaultIcon)

        }else{
            icon.image = defaultIcon
        }
        
        indicator.startAnimating()
        getUserInfo()
    }
    
    // MARK: - Viewにパーツの設置
    // MARK: ナビゲーションバーの設定
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.MainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        
        //ナビゲーションアイテムを作成
        let titleLabel:UILabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "プロフィール"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
    }
    
    // MARK: くるくるの生成
    func setActivityIndicator(){
        
        indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: viewWidth*0.35, y: viewHeight*0.25, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.hidesWhenStopped = true
        indicator.color = UIColor.MainAppColor()
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.view.bringSubview(toFront: indicator)
        
        self.view.addSubview(indicator)
    }
    
    // MARK: プロフィールビュー
    func setProfielView() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //自分の情報
        let myProfielView:UIView = UIView()
        myProfielView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth*0.56)
        myProfielView.backgroundColor = UIColor.LiginCushionLightGray()
        self.view.addSubview(myProfielView)
        
        //アイコン選択ボタン
        let iconChoseBtn:UIButton = UIButton()
        let iconChoseBtnHeight:CGFloat = myProfielView.frame.height*0.44
        iconChoseBtn.frame =  CGRect(x: viewWidth/2-iconChoseBtnHeight/2, y: myProfielView.frame.height*0.1, width: iconChoseBtnHeight, height:iconChoseBtnHeight)
        iconChoseBtn.addTarget(self, action: #selector(choseIconBtnClicked(sender:)), for: .touchUpInside)
        myProfielView.addSubview(iconChoseBtn)
        
        //卵アイコン
        icon.frame = CGRect(x: 0, y: 0, width: iconChoseBtn.frame.size.width, height:iconChoseBtn.frame.size.height)
        icon.layer.cornerRadius = iconChoseBtn.frame.size.width/2
        icon.layer.masksToBounds = true
        icon.isUserInteractionEnabled = false
        iconChoseBtn.addSubview(icon)
        
        //プラスのボタン
        let iconPlusImg:UIImageView = UIImageView()
        iconPlusImg.isUserInteractionEnabled = false
        iconPlusImg.frame = CGRect(x: iconChoseBtn.frame.size.width*0.7, y: iconChoseBtn.frame.size.width*0.7, width: iconChoseBtn.frame.size.width*0.3, height:iconChoseBtn.frame.size.height*0.3)
        iconPlusImg.image = UIImage(named:"iconChange")
        iconChoseBtn.addSubview(iconPlusImg)
        
        // 名前
        nameLabel.frame = CGRect(x: 0, y:  myProfielView.frame.height*0.58, width: viewWidth, height:myProfielView.frame.height*0.2)
        nameLabel.text = appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUserName")
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 28)
        self.view.addSubview(nameLabel)
        
        // Mail
        mailLabel.frame = CGRect(x: 0, y:  myProfielView.frame.height*0.75, width: viewWidth, height:myProfielView.frame.height*0.2)
        mailLabel.text = appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUserEmail")
        mailLabel.textAlignment = NSTextAlignment.center
        mailLabel.font = UIFont.systemFont(ofSize: 14)
        mailLabel.textColor = UIColor.gray
        self.view.addSubview(mailLabel)
    }
    
    func setTableView() {
        
        //テーブルビューの初期化
        userConfigTableView = UITableView()
        userConfigTableView.delegate = self
        userConfigTableView.dataSource = self
        userConfigTableView.frame = CGRect(x: 0, y:myProfielViewHeight, width: viewWidth, height: userConfigTableViewHeight)
        userConfigTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        userConfigTableView.backgroundColor = UIColor.LiginCushionLightGray()
        //userConfigTableView.isScrollEnabled = false
        self.view.addSubview(userConfigTableView)
    }
    
    
    //
    func choseIconBtnClicked(sender: UIButton){
        
        // インスタンス生成
        let myImagePicker = UIImagePickerController()
        myImagePicker.delegate = self
        myImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        myImagePicker.navigationBar.barTintColor = UIColor.MainAppColor()
        myImagePicker.navigationBar.tintColor = UIColor.white
        myImagePicker.navigationBar.isTranslucent = false
        self.present(myImagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: - UIImagePickerのDelgate
    
    //画像が選択された時に呼ばれる.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.view.bringSubview(toFront: self.indicator)
            self.indicator.startAnimating()
            self.doImageUpload(postImage: image)
            
        } else{
            print("Error:Class name : \(NSStringFromClass(type(of: self))) ")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //画像選択がキャンセルされた時に呼ばれる.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func doImageUpload(postImage:UIImage) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userID:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUserID"))!
        
        let imageData = UIImagePNGRepresentation(postImage)!
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "picture", fileName: "file_name.png", mimeType: "image/png")
            multipartFormData.append(userID.data(using: String.Encoding.utf8)!, withName: "user_id")
        }, to:EveryZooAPI.getUploadPicture())
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
                        
                        if json["is_success"].boolValue  {
                            let pic_id:String = json["picture"]["pic_id"].stringValue
                            self.doPost(pic_id: pic_id, postImage: postImage)
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
    
    func doPost(pic_id:String, postImage:UIImage) {
        
        let parameters: Parameters = [
            "pic_id":pic_id
        ]

        Alamofire.request(API_URL+"v0/users/"+UtilityLibrary.getUserID(), method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON{response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                self.icon.image = postImage
                self.indicator.stopAnimating()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //
    func getUserInfo() {
        //ユーザーの情報を取得する
        
        let userID:Int = Int(UtilityLibrary.getUserID())!
        Alamofire.request(EveryZooAPI.getUserInfo(userID: userID)).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                
                UtilityLibrary.setUserName(userName: json["userName"].stringValue)
                UtilityLibrary.setUserProfile(userProfile: json["profile"].stringValue)
                UtilityLibrary.setUserIconUrl(userIconUrl: json["iconUrl"].stringValue)
                
                self.indicator.stopAnimating()
                
                self.setProfielView()
                self.setTableView()
       
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    // MARK: - TableViewのデリゲートメリット
    //MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return changeUserInfoAry.count
    }
    
    //MARK: テーブルビューのセルの高さを計算する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if changeUserInfoAry[indexPath.row] == "" {
            return 24
        }else{
            return 44
        }
    }
    
    //MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        if indexPath.row == 0{
            cell.textLabel?.text = changeUserInfoAry[indexPath.row]
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            cell.textLabel?.textColor = UIColor.MainAppColor()
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }else if indexPath.row == 1{
            cell.backgroundColor = UIColor.LiginCushionLightGray()
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }else if indexPath.row == 6{
            cell.backgroundColor = UIColor.LiginCushionLightGray()
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }else{
            cell.textLabel?.text = changeUserInfoAry[indexPath.row]
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        
        return cell
    }
    
    //Mark: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            //プロフィールのプレビューが押された、ユーザー情報画面へ
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let userInfoView: UserInfoViewController = UserInfoViewController()
            userInfoView.postUserID = appDelegate.userDefaultsManager?.userDefaults.integer(forKey: "KEY_MyUserID")
            let btn_back = UIBarButtonItem()
            btn_back.title = ""
            self.navigationItem.backBarButtonItem = btn_back
            self.navigationController?.pushViewController(userInfoView, animated: true)
 
            break
        case 2:
            //ユーザー名の編集

            let alert = SCLAlertView()
            let txt = alert.addTextField(UtilityLibrary.getUserName())
            alert.addButton("変更") {
                print("Text value: \(txt.text)")
                self.changeUserName(newName: txt.text!)
                self.indicator.startAnimating()
            }
            alert.showEdit("ユーザー名変更", subTitle: "新しいユーザー名を入力してください。")
            break
        case 3:
            //ユーザー名の編集
            let vc:EditUserProfileVC = EditUserProfileVC()
            
            let btn_back = UIBarButtonItem()
            btn_back.title = ""
            self.navigationItem.backBarButtonItem = btn_back
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        default:
            
            break
        }
    }
    
    
    
    //名前の変更ボタン押されたら呼ばれます
    func changeUserName(newName: String){
        
        if (newName.isEmpty) {
            SCLAlertView().showInfo("エラー", subTitle: "ユーザー名の入力が必要です。")
            return
        }
        
        let parameters: Parameters = [
            "name":newName
        ]
        
        //print(API_URL+"v0/auth/")
        Alamofire.request(API_URL+"v0/auth/", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: UtilityLibrary.getAPIAccessHeader()).responseJSON{response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
                let json:JSON = JSON(response.result.value ?? kill)
                self.getUserInfo()
                print(json)
                
            case .failure(let error):
                print(error)
                //テーブルの再読み込み
            }
        }
    }
    
}
