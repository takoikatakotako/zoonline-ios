import UIKit
import Alamofire

class UtilityLibrary: NSObject {

    class func getAPIAccessHeader() -> HTTPHeaders {

//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let myAccessToken: String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyAccessToken"))!
//        let myClientToken: String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyClientToken"))!
//        let myExpiry: String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyExpiry"))!
//        let myUniqID: String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUniqID"))!
//
//        let headers: HTTPHeaders = [
//            "access-token": myAccessToken,
//            "client": myClientToken,
//            "expiry": myExpiry,
//            "uid": myUniqID
//        ]

        let headers: HTTPHeaders = [:]

        return headers
    }

    class func calcTextViewHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {

        let calcTextView: UITextView = UITextView()
        calcTextView.frame = CGRect(x: 0, y: 0, width: width, height: 5)
        calcTextView.font = font
        calcTextView.text = text
        calcTextView.sizeToFit()

        return calcTextView.frame.size.height
    }

    class func calcLabelSize(text: String, font: UIFont) -> CGSize {

        let calcLabel: UILabel = UILabel()
        calcLabel.text = text
        calcLabel.font = font
        let rect: CGSize = calcLabel.sizeThatFits(CGSize.zero)

        return rect
    }

    class func removeHtmlTags(text: String) -> String {

        //テキストからhtmlタグを取り除く
        var str = text

        //もっと良い感じにしたいね。
        if let range = str.range(of: "<p>") {
            str.removeSubrange(range)
        }
        if let range = str.range(of: "</p>") {
            str.removeSubrange(range)
        }

        return str
    }

    class func parseDates(text: String) -> [String: String] {
        //こんな感じの日付をパースする。"2017-10-21T19:02:58",

        var persedDic: Dictionary = ["year": "--", "month": "--", "day": "--", "hour": "--", "minute": "--", "second": "--" ]

        let split = text.components(separatedBy: "T")
        if split.count != 2 {
            return persedDic
        }

        let dateSplit = split[0].components(separatedBy: "-")
        if dateSplit.count != 3 {
            return persedDic
        }

        let timeDifferenceSplit = split[1].components(separatedBy: "+")

        let timeSplit = timeDifferenceSplit[0].components(separatedBy: ":")
        if timeSplit.count != 3 {
            return persedDic
        }

        persedDic["year"] = dateSplit[0]
        persedDic["month"] = dateSplit[1]
        persedDic["day"] = dateSplit[2]

        persedDic["hour"] = timeSplit[0]
        persedDic["minute"] = timeSplit[1]
        persedDic["second"] = timeSplit[2]
        return persedDic
    }
}
