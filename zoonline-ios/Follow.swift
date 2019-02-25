import UIKit
import Firebase

class Follow {
    var uid: String
    var targetUid: String
    var isFollow: Bool

    init(uid: String, targetUid: String, isFollow: Bool) {
        self.uid = uid
        self.targetUid = targetUid
        self.isFollow = isFollow
    }

    func save(error: @escaping (NSError?) -> Void) {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "uid": uid,
            "target_uid": targetUid,
            "is_follow": isFollow,
            "created_at": FieldValue.serverTimestamp()
        ]
        db.collection("follow").addDocument(data: data, completion: { err in
            error(err as NSError?)
        })
    }

    static func xxxxxx(uid: String, targetUid: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("follow").whereField("uid", isEqualTo: uid).whereField("target_uid", isEqualTo: targetUid).limit(to: 1).getDocuments { (querySnapshot, err) in
            if let err = err {
                print(err)
                completion(false)
            } else {
                for document in querySnapshot!.documents {
                    if let bool = document.get("is_follow") as? Bool {
                        completion(bool)
                        return
                    }
                }
                completion(false)
            }
        }
    }
}
