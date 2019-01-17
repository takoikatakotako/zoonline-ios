import UIKit

protocol SetTextDelegate: class {
    func setComment(comment: String)
}

class SetPostCommentViewController: UIViewController, UITextViewDelegate {

    var text: String!

    //viewParts
    private var textView: UITextView!
    weak var delegate: SetTextDelegate?

    init(comment: String?) {
        super.init(nibName: nil, bundle: nil)
        if let text = comment {
            self.text = text
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        let rightNavBtn = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(doClose(sender:)))
        navigationItem.rightBarButtonItem = rightNavBtn

        textView = UITextView()
        textView.frame = view.frame
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.delegate = self
        textView.text = text
        view.addSubview(textView)
    }

    //投稿ボタンが押されたら呼ばれる
    @objc internal func doClose(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - TextView delegate methods
    //テキストビューが変更された
    func textViewDidChange(_ textView: UITextView) {
        delegate?.setComment(comment: textView.text)
    }

    // テキストビューにフォーカスが移った
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }

    // テキストビューからフォーカスが失われた
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
