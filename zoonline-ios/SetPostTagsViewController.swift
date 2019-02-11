import UIKit

protocol SetTagsDelegate: class {

    func setTags(ary: [String])
}

class SetPostTagsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    // segue
    private var tagsAry: [String]!

    //ViewParts
    var tagTextField: UITextField!
    let placeHolder = "登録するタグ名"
    var tagTableView: UITableView!

    //delegate
    weak var delegate: SetTagsDelegate?

    init(tagsAry: [String]) {
        self.tagsAry = tagsAry
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // width, height
        let width = view.frame.width
        let height = view.frame.height
        let margin: CGFloat = 16
        let tagTextFieldHeight: CGFloat = 40
        let tagTableViewHeight = height - tagTextFieldHeight
        view.backgroundColor = UIColor.white

        // close button
        let rightNavBtn = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(doClose(sender:)))
        navigationItem.rightBarButtonItem = rightNavBtn

        // text field
        tagTextField = UITextField()
        tagTextField.frame = CGRect(x: width * 0.1, y: margin, width: width * 0.8, height: tagTextFieldHeight)
        tagTextField.placeholder = placeHolder
        tagTextField.textColor = UIColor.gray
        tagTextField.textAlignment = NSTextAlignment.left
        tagTextField.delegate = self
        let border = CALayer()
        let borderWidth = CGFloat(2.0)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: tagTextField.frame.size.height - borderWidth, width: tagTextField.frame.size.width, height: 1)
        border.borderWidth = width
        tagTextField.layer.addSublayer(border)
        view.addSubview(tagTextField)

        // table view
        tagTableView = UITableView()
        tagTableView.delegate = self
        tagTableView.dataSource = self
        tagTableView.frame = CGRect(x: width * 0.1, y: tagTextFieldHeight + margin * 2, width: width * 0.8, height: tagTableViewHeight)
        tagTableView.register(TagListTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TagListTableViewCell.self))
        tagTableView.separatorInset = .zero
        tagTableView.separatorColor = UIColor.white
        tagTableView.rowHeight = 40
        view.addSubview(tagTableView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.setTags(ary: tagsAry)
    }

    // close view
    @objc func doClose(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    // delete tag
    @objc func deleatBtnClicked(sender: UIButton) {
        tagsAry.remove(at: sender.tag)
        tagTableView.reloadData()
    }

    // MARK: UITextField delegate methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text!)")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")

        // close keyboard
        textField.resignFirstResponder()
        guard let text = textField.text else {
            return true
        }
        tagTextField.text = ""
        tagsAry.append(text)
        tagTableView.reloadData()
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
}
