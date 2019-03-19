import UIKit
import Firebase

class Favorite {
    static let name = "favorite"
    static let uid = "uid"
    static let postId = "post_id"
    static let createdAt = "created_at"

    var uid: String!
    var postId: String!
//    var isFollow: Bool
//    var createdAt: Date!

    var postImageReference: StorageReference {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        return storageRef.child("post/" + postId + "/image.png")
    }

    init(document: DocumentSnapshot) {
        self.uid = document.get(Favorite.uid) as! String
        self.postId = document.get(Favorite.postId) as! String
    }
}
