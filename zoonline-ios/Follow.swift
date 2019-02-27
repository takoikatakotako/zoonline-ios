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
            targetUid: isFollow
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
