import UIKit

protocol SetTagsDelegate: class {

    func setTags(ary: [String])
}

class SetPostTagsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    //width, height

    var postTagLabelHeight: CGFloat!
    var setTagTextFieldSpaceHeight: CGFloat!
    var setTagTextFieldHeight: CGFloat!
    var tagTableViewHeight: CGFloat!

    //segue
    var tagsAry: [String]!

    //ViewParts
    var setTagTextField: UITextField!
    var tagTableView: UITableView!

    //delegate
    weak var delegate: SetTagsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewWidth = view.frame.width
        let viewHeight = view.frame.height

        postTagLabelHeight = viewWidth * 0.14
        setTagTextFieldSpaceHeight = viewWidth * 0.02
        setTagTextFieldHeight = viewWidth * 0.15
        tagTableViewHeight = viewHeight
        view.backgroundColor = UIColor.white

        // close button
        let rightNavBtn = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(doClose(sender:)))
        navigationItem.rightBarButtonItem = rightNavBtn

        // text field
        setTagTextField = UITextField()
        setTagTextField.frame = CGRect(x: viewWidth * 0.1, y: 0, width: viewWidth * 0.8, height: setTagTextFieldHeight)
        setTagTextField.text = "登録するタグ名"
        setTagTextField.textColor = UIColor.gray
        setTagTextField.textAlignment = NSTextAlignment.left
        setTagTextField.backgroundColor = UIColor.red
        setTagTextField.delegate = self
        view.addSubview(setTagTextField)

        let setTagTextFieldLine: UIView = UIView()
        setTagTextFieldLine.backgroundColor = UIColor.gray
        var linePos: CGFloat = postTagLabelHeight + setTagTextFieldSpaceHeight
        linePos = linePos + setTagTextFieldHeight!
        setTagTextFieldLine.frame = CGRect(x: viewWidth * 0.1, y: linePos, width: viewWidth * 0.8, height: 1)
        view.addSubview(setTagTextFieldLine)

        // table view
        tagTableView = UITableView()
        tagTableView.delegate = self
        tagTableView.dataSource = self
        tagTableView.frame = CGRect(x: viewWidth * 0.1, y: ( setTagTextFieldHeight!) + 2, width: viewWidth * 0.8, height: tagTableViewHeight)
        tagTableView.register(TagListTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TagListTableViewCell.self))
        tagTableView.separatorInset = UIEdgeInsets.zero
        tagTableView.separatorInset = .zero
        tagTableView.separatorColor = UIColor.white
        UITableView.appearance().layoutMargins = UIEdgeInsets.zero
        UITableViewCell.appearance().layoutMargins = UIEdgeInsets.zero
        view.addSubview(tagTableView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.setTags(ary: tagsAry)
    }

    //タグ画面を閉じる
    @objc internal func doClose(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: UITextField delegate methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
        if textField.text == "登録するタグ名" {
            textField.text = ""
        }
    }

    //UITextFieldが編集された直後に呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text!)")
    }

    //改行ボタンが押された際に呼ばれる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")

        // 改行ボタンが押されたらKeyboardを閉じる処理.
        textField.resignFirstResponder()

        if textField.text == "" {
            return true
        }

        tagsAry.append(textField.text!)
        tagTableView.reloadData()
        textField.text = "登録するタグ名"

        return true
    }

    // MARK: Tableview delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagsAry.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TagListTableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TagListTableViewCell.self), for: indexPath) as! TagListTableViewCell
        cell.tagLabel.text = tagsAry[tagsAry.count - indexPath.row - 1]
        cell.deleateBtn.tag = tagsAry.count - indexPath.row - 1
        cell.deleateBtn.addTarget(self, action: #selector(deleatBtnClicked(sender:)), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
    }

    //角丸ボタンが押されたら呼ばれます
    @objc func deleatBtnClicked(sender: UIButton) {
        tagsAry.remove(at: sender.tag)
        tagTableView.reloadData()
    }
}
