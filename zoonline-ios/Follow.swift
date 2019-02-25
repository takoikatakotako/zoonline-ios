import UIKit
import Firebase

class Follow {
    var uid: String
    var targetUid: String
    var isFollow: Bool

    init(uid: String, targetUid: String, isFollow: Bool ) {
        self.uid = uid
        self.targetUid = targetUid
        self.isFollow = isFollow
    }

    func save(error: @escaping () -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("follow").document(String(uid))
        let data: [String: Any] = [
            targetUid: isFollow
        ]
        docRef.updateData(data) { err in
            if let err = err {
                print("Error writing document: \(err)")
                error()
            } else {
                print("Document successfully written!")
            }
        }
    }
}
