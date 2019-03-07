import UIKit

extension UIViewController {
    func showMessageAlert(message: String) {
        let actionAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        let closeAction = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.cancel, handler: nil)
        actionAlert.addAction(closeAction)
        present(actionAlert, animated: true, completion: nil)
    }
}
