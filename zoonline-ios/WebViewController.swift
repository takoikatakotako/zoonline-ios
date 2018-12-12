import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    //
    var url: String!
    var navTitle: String!

    //
    var webview: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let leftNavBtn = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(doClose(sender:)))
        navigationItem.leftBarButtonItem = leftNavBtn

        let url: URL = URL(string: self.url)!
        let request: NSURLRequest = NSURLRequest(url: url)

        // WebView
        webview = WKWebView()
        webview.backgroundColor = .white
        webview.frame = view.frame
        webview.load(request as URLRequest)
        view = webview
    }

    @objc func doClose(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
