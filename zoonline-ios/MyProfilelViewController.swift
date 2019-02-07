import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import GoogleSignIn
import Alamofire
import SwiftyJSON
import SCLAlertView
import SDWebImage

class MyProfilelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SampleDelegate {

    var handle: AuthStateDidChangeListenerHandle!

    var indicator: UIActivityIndicatorView!

    var uid: String!

    //テーブルビューインスタンス
    var userConfigTableView: UITableView!

    var myProfileView: MyProfileView!

    //表示するもの
    let changeUserInfoAry: [String] = ["ユーザー名の変更", "自己紹介の変更", "メールアドレスの変更", "パスワードの変更"]

    var picker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "プロフィール"
        view.backgroundColor = UIColor(named: "backgroundGray")

        // NavigationBar
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton

        myProfileView = MyProfileView()
        myProfileView.frame.size = CGSize(width: view.frame.width, height: 240)
        myProfileView.selectIcon.addTarget(self, action: #selector(choseIconBtnClicked(sender:)), for: .touchUpInside)

        // picker
        picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = true
        picker.view.backgroundColor = .white
        picker.navigationBar.isTranslucent = false
        picker.navigationBar.barTintColor = .blue

        //テーブルビューの初期化
        userConfigTableView = UITableView.init(frame: view.frame, style: .grouped)
        userConfigTableView.delegate = self
        userConfigTableView.dataSource = self
        userConfigTableView.tableHeaderView = myProfileView
        userConfigTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        userConfigTableView.backgroundColor = UIColor(named: "backgroundGray")
        userConfigTableView.rowHeight = 60
        view.addSubview(userConfigTableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            print(auth)
            print(user)
        }

        if let user = Auth.auth().currentUser {
            // User is signed in.
            uid = user.uid
            getUserName()
            myProfileView.userEmail.text = user.email

            let storage = Storage.storage()
            let storageRef = storage.reference()
            let reference = storageRef.child("user/" + String(uid) + "/icon.png")
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    // Uh-oh, an error occurred!
                    print(error)
                } else {
                    // Data for "images/island.jpg" is returned
                    let image = UIImage(data: data!)
                    self.myProfileView.userThumbnail.image = image
                }
            }

            /*
            reference.getData(maxSize: <#T##Int64#>, completion: <#T##(Data?, Error?) -> Void#>)
            
            
            putData(data, metadata: nil, completion: { metaData, error in
                print(metaData as Any)
                print(error as Any)
            })
            */
        } else {
            // No user is signed in.
            // TODO: 即ログアウトさせる
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    // MARK: - Viewにパーツの設置
    @objc func choseIconBtnClicked(sender: UIButton) {
        present(picker, animated: true, completion: nil)
    }

    func editUserName() {
        //UIAlertControllerを用意する
        let actionAlert = UIAlertController(title: "", message: "新しいユーザー名を入力してください。", preferredStyle: UIAlertController.Style.alert)
        let kabigonAction = UIAlertAction(title: "変更", style: UIAlertAction.Style.default, handler: { (_: UIAlertAction!) in
            let textFields = actionAlert.textFields
            if textFields != nil {
                for textField: UITextField in textFields! {
                    self.setUserName(name: textField.text!)
                    self.myProfileView.userName.text = textField.text
                }
            }
        })
        actionAlert.addAction(kabigonAction)

        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        actionAlert.addAction(cancelAction)

        actionAlert.addTextField(configurationHandler: { (text: UITextField!) -> Void in
            text.placeholder = "new user name"
        })
        present(actionAlert, animated: true, completion: nil)
    }

    func setUserName(name: String) {
        let db = Firestore.firestore()
        let docData: [String: Any] = [
            "name": name
        ]
        db.collection("user").document(String(uid)).updateData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }

    func getUserName() {
        let db = Firestore.firestore()
        let docRef = db.collection("user").document(String(uid))
        docRef.getDocument { (document, _) in
            if let document = document, document.exists {
                if let data = document.data() {
                    if let name = data["name"] as? String {
                        self.myProfileView.userName.text = name
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }

    // プロフィール変更
    func changeMyProfile(profile: String) {
        let db = Firestore.firestore()
        let docData: [String: Any] = [
            "profile": profile
        ]
        db.collection("user").document(String(uid)).updateData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }

    func showMessageAlert(message: String) {
        let actionAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        let closeAction = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.cancel, handler: nil)
        actionAlert.addAction(closeAction)
        present(actionAlert, animated: true, completion: nil)
    }

    // MARK: -
    func setImage(image: UIImage) {

    }

    // MARK: - UIImagePicker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var image: UIImage!
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = originalImage
        }
        myProfileView.userThumbnail.image = image
        let storage = Storage.storage()
        let storageRef = storage.reference()
        if let data = image.pngData() {
            let reference = storageRef.child("user/" + String(uid) + "/icon.png")
            reference.putData(data, metadata: nil, completion: { metaData, error in
                print(metaData as Any)
                print(error as Any)
            })
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return changeUserInfoAry.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        if indexPath.section == 0 {
            cell.textLabel?.text = "プロフィールのプレビュー"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            cell.textLabel?.textColor = UIColor.init(named: "main")
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        } else {
            cell.textLabel?.text = changeUserInfoAry[indexPath.row]
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let userInfoViewController = UserInfoViewController(uid: String(uid))
            navigationController?.pushViewController(userInfoViewController, animated: true)
        case 1:
            switch indexPath.row {
            case 0:
                editUserName()
                break
            case 1:
                //プロフィールの編集
                let vc = EditUserProfileViewController()
                vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
                break
            case 2:
                //メールアドレスの変更
                print("メールアドレス")
                showMessageAlert(message: "メールアドレス変更はあっちからおなしゃす")
                break
            case 3:
                //パスワードの変更
                print("パスワード")
                showMessageAlert(message: "パスワード変更はあっちからおなしゃす")
                break
            default: break
            }
        default: break
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
