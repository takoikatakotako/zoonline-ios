import UIKit

class PostCommentViewController: UIViewController {
    var commentTextView: UITextView!

    var uid: String!
    var postId: String!

    init(uid: String, postId: String) {
        self.uid = uid
        self.postId = postId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    @objc func postComments(sender: UIButton) {
        let comment = Comment(uid: uid, postId: postId, comment: "コメントだお")
        comment.save(error: { error in
            if let error = error {

            }

        })
    }
}
