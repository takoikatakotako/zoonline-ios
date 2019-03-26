import UIKit
import Firebase

class Post {
    static let name = "post"
    static let uid = "uid"
    static let postId = "post_id"
    static let comment = "comment"
    static let createdAt = "created_at"

    var postId: String!
    var uid: String!
    var comment: String!
    var createdAt: Date!

    var date: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.locale = Locale.current
        return formatter.string(from: createdAt)
    }

    var imageReference: StorageReference {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        return storageRef.child("post/" + postId + "/image.png")
    }

    static func imageReference(postId: String) -> StorageReference {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        return storageRef.child("post/" + postId + "/image.png")
    }

    init(id: String, document: DocumentSnapshot) {
        self.postId = id

        if let uid = document.get(Post.postId) as? String {
            self.uid = uid
        } else {
            self.uid = "Error"
        }

        if let comment = document.get(Post.comment) as? String {
            self.comment = comment
        } else {
            self.comment = "エラーです(´・ω・｀)"
        }

        if let date = document.get(Post.createdAt) as? Date {
            self.createdAt = date
        } else {
            self.createdAt = Date()
        }
    }
}
