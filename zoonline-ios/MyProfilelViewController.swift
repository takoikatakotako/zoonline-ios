import UIKit
import FirebaseAuth
import GoogleSignIn
import Alamofire
import SwiftyJSON
import SCLAlertView
import SDWebImage

class MyProfilelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var handle: AuthStateDidChangeListenerHandle!

    var indicator: UIActivityIndicatorView!

    //プロフィール
    var icon: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    let mailLabel: UILabel = UILabel()

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
            myProfileView.userName.text = user.displayName
            myProfileView.userEmail.text = user.email
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

    // MARK: - UIImagePicker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            myProfileView.userThumbnail.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            myProfileView.userThumbnail.image = originalImage
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
            let userInfoViewController = UserInfoViewController()
            navigationController?.pushViewController(userInfoViewController, animated: true)
        case 1 :
            switch indexPath.row {
            case 0:
                //プロフィールのプレビューが押された、ユーザー情報画面へ
                let userInfoViewController: UserInfoViewController = UserInfoViewController()
                navigationController?.pushViewController(userInfoViewController, animated: true)
                break
            case 1:
                //ユーザー名の編集

                let alert = SCLAlertView()
                let txt = alert.addTextField(UtilityLibrary.getUserName())
                alert.addButton("変更") {
                    print("Text value: \(String(describing: txt.text))")
                    self.indicator.startAnimating()
                }
                alert.showEdit("ユーザー名変更", subTitle: "新しいユーザー名を入力してください。")
                break
            case 2:
                //プロフィールの編集
                let vc: EditUserProfileViewController = EditUserProfileViewController()
                navigationController?.pushViewController(vc, animated: true)
                break
            case 3:
                //メールアドレスの変更
                print("メールアドレス")
                let alert = SCLAlertView()
                let txt = alert.addTextField(UtilityLibrary.getUserEmail())
                alert.addButton("変更") {
                    print("Text value: \(String(describing: txt.text))")
                    self.indicator.startAnimating()
                }
                alert.showEdit("メールアドレス変更", subTitle: "新しいメールアドレスを入力してください。\n(変更後にログアウトします。)")
                break
            case 5:
                //パスワードの変更
                print("パスワード")
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
