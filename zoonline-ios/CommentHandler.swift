import UIKit
import Firebase

class CommentHandler: Comment {

    static func isCommented(uid: String, postId: String, completion: @escaping (Bool, NSError?) -> Void) {
        let db = Firestore.firestore()
        let docsRef = db.collection(Comment.name)
            .whereField(Comment.uid, isEqualTo: uid)
            .whereField(Comment.postId, isEqualTo: postId)
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
