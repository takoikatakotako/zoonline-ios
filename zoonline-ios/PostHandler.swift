import UIKit
import Firebase

class PostHandler: Post {

    static func featchUserPosts(uid: String, completion: @escaping ([Post], NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection(name).whereField(Post.uid, isEqualTo: uid).order(by: createdAt, descending: true).limit(to: 50).getDocuments { (querySnapshot, error) in
            var posts: [Post] = []
            if let error = error {
                print("Error getting documents: \(error)")
                completion(posts, error as NSError)
                return
            }

            for document in querySnapshot!.documents {
                let post = Post(id: document.documentID, data: document.data())
                posts.append(post)
            }
            completion(posts, nil)
        }
    }
}
