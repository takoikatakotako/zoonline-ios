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

    static func featchPost(postId: String, completion: @escaping (Post, NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection(Post.name).whereField(Post.postId, isEqualTo: postId).order(by: createdAt, descending: true).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(Post(), error as NSError)
                return
            }

            guard let document = querySnapshot?.documents.first else {
                completion(Post(), nil)
                return
            }

            let post = Post(id: postId, data: document.data())
            completion(post, nil)
        }
    }
}
