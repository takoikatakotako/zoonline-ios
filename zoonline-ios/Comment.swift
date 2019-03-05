import UIKit
import Firebase

class Comment {
    static let name = "comment"

    // field
    static let uid = "uid"
    static let postId = "post_id"
    static let comment = "comment"
    static let createdAt = "created_at"

    var uid: String
    var postId: String
    var comment: String

    init(uid: String, postId: String, comment: String) {
        self.uid = uid
        self.postId = postId
        self.comment = comment
    }

    init(document: DocumentSnapshot) {
        self.uid = document.get(Comment.uid) as! String
        self.postId = document.get(Comment.postId) as! String
        self.comment = document.get(Comment.comment) as! String
    }

    func save(error: @escaping (NSError?) -> Void) {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            Comment.uid: uid,
            Comment.postId: postId,
            Comment.comment: comment,
            Comment.createdAt: FieldValue.serverTimestamp()
        ]
        db.collection(Comment.name).addDocument(data: data, completion: { err in
            error(err as NSError?)
        })
    }

    // Static Methods
    static func featchComments(postId: String, completion: @escaping ([Comment], NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection(Comment.name).whereField(Comment.postId, isEqualTo: postId).order(by: Comment.createdAt, descending: true).limit(to: 50).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion([], err as NSError)
                return
            }

            var comments: [Comment] = []
            for document in querySnapshot!.documents {
                let comment = Comment(document: document)
                comments.append(comment)
            }
            completion(comments, nil)
        }
    }
}
