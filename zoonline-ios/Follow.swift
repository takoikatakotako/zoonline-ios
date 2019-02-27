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
        db.collection("follow").document(uid).setData(data, completion: { err in
            error(err as NSError?)
        })
    }

    static func xxxxxx(uid: String, targetUid: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("follow").document(uid)
        docRef.getDocument { (document, _) in
            if let document = document, document.exists {
                if let data = document.data() {
                    if let isFollow = data[targetUid] as? Bool {
                        completion(isFollow)
                    }
                }
            } else {
                print("Document does not exist")
            }
            completion(false)
        }
    }
}
