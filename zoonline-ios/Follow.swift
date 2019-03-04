import UIKit
import Firebase

class Follow {
    static let name = "follow"

    static func follow(uid: String, followUid: String, completion: @escaping (NSError?) -> Void) {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "uid": uid,
            "follow_uid": followUid,
            "is_follow": true,
            "created_at": FieldValue.serverTimestamp()
        ]
        db.collection("follow").addDocument(data: data, completion: { err in
            completion(err as NSError?)
        })
    }

    static func unFollow(uid: String, followUid: String, completion: @escaping (NSError?) -> Void) {
        let db = Firestore.firestore()
        let docsRef = db.collection("follow").whereField("uid", isEqualTo: uid).whereField("follow_uid", isEqualTo: followUid).whereField("is_follow", isEqualTo: true)
        docsRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                completion(err as NSError)
                return
            }

            for document in querySnapshot!.documents {
                db.collection(name).document(document.documentID).delete { err in
                    if let err = err {
                        completion(err as NSError)
                        return
                    }
                }
            }
            completion(nil)
        }
    }

    static func isFollow(uid: String, followUid: String, completion: @escaping (Bool, NSError?) -> Void) {
        let db = Firestore.firestore()
        let docsRef = db.collection("follow").whereField("uid", isEqualTo: uid).whereField("follow_uid", isEqualTo: followUid).whereField("is_follow", isEqualTo: true)
        docsRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(false, err as NSError)
                return
            }
            if querySnapshot!.documents.count > 0 {
                completion(true, nil)
            } else {
                completion(false, nil)
            }
        }
    }
}
