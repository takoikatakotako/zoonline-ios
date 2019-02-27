import UIKit
import Firebase

class Comment {
    var uid: String
    var postId: String
    var comment: String

    init(uid: String, postId: String, comment: String) {
        self.uid = uid
        self.postId = postId
        self.comment = comment
    }

    func save(error: @escaping (NSError?) -> Void) {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "uid": uid,
            "post_id": postId,
            "comment": comment,
            "created_at": FieldValue.serverTimestamp()
        ]
        db.collection("comment").addDocument(data: data, completion: { err in
            error(err as NSError?)
        })

    }
}
