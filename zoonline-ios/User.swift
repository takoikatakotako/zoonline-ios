import UIKit
import Firebase

class User {
    static let name = "user"
    static let defaultNickname = "名無しさん"
    static let uid = "uid"
    static let nickname = "nickname"
    static let profile = "profile"
    static let createdAt = "created_at"

    var uid: String
    var nickname: String
    var profile: String

    init(uid: String, document: DocumentSnapshot) {
        self.uid = uid

        if let name = document.get(User.nickname) as? String {
            self.nickname = name
        } else {
            self.nickname = "ななしさん"
        }
        
        if let profile = document.get(User.profile) as? String {
            self.profile = profile
        } else {
            self.profile = ""
        }
    }

    init(uid: String) {
        self.uid = uid
        self.nickname = User.defaultNickname
        self.profile = ""
    }

    // MARK: static methods
    static func featchUserName(uid: String, completion: @escaping (String, NSError?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection(name).document(String(uid))
        docRef.getDocument { (document, error) in
            if let error = error {
                completion(defaultNickname, error as NSError)
                return
            }

            guard let document = document, document.exists else {
                completion(defaultNickname, nil)
                return
            }

            guard let data = document.data() else {
                completion(defaultNickname, nil)
                return
            }

            if let name = data["name"] as? String {
                completion(name, nil)
                return
            }

            completion(defaultNickname, nil)
            return
        }
    }

    static func getUserIconPath(uid: String) -> String {
        return "user/" + uid + "/icon.png"
    }
}
