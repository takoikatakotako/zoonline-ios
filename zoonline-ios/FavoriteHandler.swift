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

    static func unFavorite(uid: String, postId: String, completion: @escaping (NSError?) -> Void) {
        let db = Firestore.firestore()
        let docsRef = db.collection(Favorite.name)
            .whereField(Favorite.uid, isEqualTo: uid)
            .whereField(Favorite.postId, isEqualTo: postId)
        docsRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                completion(err as NSError)
                return
            }

            for document in querySnapshot!.documents {
                db.collection(name).document(document.documentID).delete { err in
                    if let err = err {
                        completion(err as NSError)
                        return
                    }
                }
            }
            completion(nil)
        }
    }

    static func isFavorited(uid: String, postId: String, completion: @escaping (Bool, NSError?) -> Void) {
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

    static func featchFavorite(uid: String, completion: @escaping ([Favorite], NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection(name).whereField(Favorite.uid, isEqualTo: uid).order(by: createdAt, descending: true).limit(to: 50).getDocuments { (querySnapshot, error) in
            var favorites: [Favorite] = []
            if let error = error {
                print("Error getting documents: \(error)")
                completion(favorites, error as NSError)
                return
            }

            for document in querySnapshot!.documents {
                let favorite = Favorite(document: document)
                favorites.append(favorite)
            }
            completion(favorites, nil)
        }
    }
}
