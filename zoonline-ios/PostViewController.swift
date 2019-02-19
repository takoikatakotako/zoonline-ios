import UIKit
import Firebase
import FirebaseAuth
import Alamofire
import SwiftyJSON
import SCLAlertView

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SetTextDelegate, SetTagsDelegate {

    var uid: String!

    var picker: UIImagePickerController!

    //width, height

    //views
    private var postTableView: UITableView!
    var myImagePicker: UIImagePickerController!
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()

    //datas
    public var postImageWidth: CGFloat! = 100
    public var postImageHeight: CGFloat! = 62
    public var titleStr: String! = "タイトルをつけてみよう"

    //サポートボタン
    let supportBtn: UIButton = UIButton()

    //投稿フラグ
    var isSelectedImage = false

    //
    private var image: UIImage!
    private var comment: String!
    private var tagsAry: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "投稿する"

        // NavigationBar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let rightNavBtn = UIBarButtonItem(image: UIImage(named: "submit_nav_btn")!, style: .plain, target: self, action: #selector(postBarBtnClicked))
        navigationItem.rightBarButtonItem = rightNavBtn
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(dismissView))

        // TableView
        postTableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        postTableView.frame = view.frame
        postTableView.dataSource = self
        postTableView.delegate = self
        postTableView.backgroundColor = UIColor(named: "mypageArrowGray")
        postTableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        postTableView.register(PostImageTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostImageTableViewCell.self))
        postTableView.register(PostCommentTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostCommentTableViewCell.self))
        postTableView.register(PostTagTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PostTagTableViewCell.self))
        postTableView.register(NoLoginTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(NoLoginTableViewCell.self))
        postTableView.backgroundColor = .lightGray
        postTableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        view.addSubview(postTableView)

        picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = true // Whether to make it possible to edit the size etc after selecting the image
        // set picker's navigationBar appearance
        picker.view.backgroundColor = .white
        picker.navigationBar.isTranslucent = false
        picker.navigationBar.barTintColor = UIColor(named: "main")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postTableView.reloadData()

        if let user = Auth.auth().currentUser {
            // User is signed in.
            uid = user.uid
        } else {
            // No user is signed in.
            // TODO: 即ログアウトさせる
        }
    }

    // MARK: Navigation Bar Button Actions
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    // 投稿ボタンが押されたら呼ばれる
    @objc func postBarBtnClicked() {
        if image == nil {
            SCLAlertView().showInfo("エラー", subTitle: "画像が選択されていません。")
            return
        }

        if comment.isEmpty {
            SCLAlertView().showInfo("エラー", subTitle: "コメントを入力して下さい。")
            return
        }
        write(uid: uid, comment: comment, tagsAry: tagsAry, image: image)
    }

    func write(uid: String, comment: String, tagsAry: [String], image: UIImage) {
        // TODO: トランザクション
        var ref: DocumentReference?
        let db = Firestore.firestore()
        let docData: [String: Any] = [
            "uid": uid,
            "comment": comment,
            "tag": tagsAry,
            "created_at": Date(),
            "uploaded_at": Date()
        ]
        ref = db.collection("post").addDocument(data: docData) { err in
            if let err = err {
                print("Error adding document: \(err)")
                SCLAlertView().showInfo("", subTitle: "ドキュメント")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.uploadImage(documentID: ref!.documentID, image: image)
            }
        }
    }

    func uploadImage(documentID: String, image: UIImage) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        if let data = image.pngData() {
            let reference = storageRef.child("post/" + String(documentID) + "/image.png")
            reference.putData(data, metadata: nil, completion: { metaData, error in
                print(metaData as Any)
                print(error as Any)

            })
        }
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

    func doPost(pic_id: String) {
    }

    // MARK: - TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

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
            let cell: PostCommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PostCommentTableViewCell.self), for: indexPath) as! PostCommentTableViewCell
            cell.postTextView.text = (comment == nil) ? "コメントを書いて見ましょう" : comment
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
            let writeCommentViewController = SetPostCommentViewController(comment: comment)
            writeCommentViewController.delegate = self
            navigationController?.pushViewController(writeCommentViewController, animated: true)
        }  else if indexPath.section == 2 {
            let setPostTagsViewController = SetPostTagsViewController(tagsAry: tagsAry)
            setPostTagsViewController.delegate = self
            navigationController?.pushViewController(setPostTagsViewController, animated: true)
        }
    }

    // MARK: Set Comment Delate Methods
    func setComment(comment: String) {
        self.comment = comment
    }

    // MARK: Set Tag Delate Methods
    func setTags(ary: [String]) {
        self.tagsAry = ary
    }

    // MARK: ImageVicker Delegate Methods
    // called when image picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }

    // called when cancel select image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // close picker modal
        dismiss(animated: true, completion: nil)
    }
}
