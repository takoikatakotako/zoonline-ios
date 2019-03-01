import UIKit
import Firebase

class User {
    static let collectionName = "user"
    static let defaultUserName = "名無しさん"

    // MARK: static methods
    static func featchUserName(uid: String, completion: @escaping (String, NSError?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection(collectionName).document(String(uid))
        docRef.getDocument { (document, error) in
            if let error = error {
                completion(defaultUserName, error as NSError)
                return
            }

            guard let document = document, document.exists else {
                completion(defaultUserName, nil)
                return
            }

            guard let data = document.data() else {
                completion(defaultUserName, nil)
                return
            }

            if let name = data["name"] as? String {
                completion(name, nil)
                return
            }

            completion(defaultUserName, nil)
            return
        }
    }

    static func getUserIconPath(uid: String) -> String {
        return "user/" + uid + "/icon.png"
    }
}
