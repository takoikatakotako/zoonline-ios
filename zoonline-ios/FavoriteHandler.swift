import UIKit
import Firebase

class FavoriteHandler: Favorite {

    static func favorite(uid: String, postId: String, completion: @escaping (NSError?) -> Void) {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            Favorite.uid: uid,
            Favorite.postId: postId,
            Follow.createdAt: FieldValue.serverTimestamp()
        ]
        db.collection(Favorite.name).addDocument(data: data, completion: { err in
            completion(err as NSError?)
        })
    }

    static func didFavorite(uid: String, postId: String, completion: @escaping (Bool, NSError?) -> Void) {
        let db = Firestore.firestore()
        let docsRef = db.collection(Favorite.name)
            .whereField(Favorite.uid, isEqualTo: uid)
            .whereField(Favorite.postId, isEqualTo: postId)
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
