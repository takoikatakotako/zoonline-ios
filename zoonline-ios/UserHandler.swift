import UIKit
import Firebase

class UserHandler: User {

    static func featchUser(uid: String, completion: @escaping (User?, NSError?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection(name).document(uid)
        docRef.getDocument { (document, error) in
            if let error = error {
                completion(nil, error as NSError)
                return
            }

            guard let document = document, document.exists else {
                completion(User(uid: uid), nil)
                return
            }

            completion(User(uid: uid, document: document), nil)
            return
        }
    }

    static func setNickname(uid: String, nickname: String, completion: @escaping (NSError?) -> Void) {
        let data = [User.nickname: nickname]
        let db = Firestore.firestore()
        let docRef = db.collection(name).document(uid)
        docRef.setData(data, merge: true, completion: { error in
            if let error = error {
                completion(error as NSError)
            } else {
                completion(nil)
            }
        })
    }

    static func setProfile(uid: String, profile: String, completion: @escaping (NSError?) -> Void) {
        let data = [User.profile: profile]
        let db = Firestore.firestore()
        let docRef = db.collection(name).document(uid)
        docRef.setData(data, merge: true, completion: { error in
            if let error = error {
                completion(error as NSError)
            } else {
                completion(nil)
            }
        })
    }
}
