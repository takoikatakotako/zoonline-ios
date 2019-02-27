import UIKit

class PostCommentViewController: UIViewController {
    var commentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "投稿", style: .plain, target: self, action: #selector(postComments(sender:)))

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        commentTextView = UITextView()
        commentTextView.font = UIFont.systemFont(ofSize: 20)
        setTextViewSize(keyboardHeight: 0)
        view.addSubview(commentTextView)
        commentTextView.becomeFirstResponder()
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            setTextViewSize(keyboardHeight: keyboardRectangle.height)
        }
    }

    func setTextViewSize(keyboardHeight: CGFloat) {
        let width = view.frame.width
        let height = view.frame.height
        let margin: CGFloat = 8
        let keyboardWidth = width - margin * 2
        let keyboardHeight = height - margin - keyboardHeight
        commentTextView.frame = CGRect(x: margin, y: margin, width: keyboardWidth, height: keyboardHeight)
    }

    @objc internal func postComments(sender: UIButton) {

        // let comment = Comment(uid: <#T##String#>, postId: <#T##String#>, userName: <#T##String#>, comment: <#T##String#>)

    }
}
