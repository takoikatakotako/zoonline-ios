import UIKit
import Firebase

class Follow {

    static func follow(uid: String, followUid: String, error: @escaping (NSError?) -> Void) {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "uid": uid,
            "follow_uid": followUid,
            "is_follow": true,
            "created_at": FieldValue.serverTimestamp()
        ]
        db.collection("follow").addDocument(data: data, completion: { err in
            error(err as NSError?)
        })
    }

    static func unFollow(uid: String, followUid: String, error: @escaping (NSError?) -> Void) {
        let db = Firestore.firestore()
        let docsRef = db.collection("follow").whereField("uid", isEqualTo: uid).whereField("follow_uid", isEqualTo: followUid).whereField("is_follow", isEqualTo: true)
        docsRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                error(err as NSError)
                return
            }

            for document in querySnapshot!.documents {
                db.collection("follow").document(document.documentID).delete { err in
                    if let err = err {
                        error(err as NSError)
                    }
                }
            }
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
                return
            } else {
                completion(false, nil)
                return
            }
        }
    }
}
