import UIKit
import Firebase

class FollowHandler: Follow {

    static func featchFollowee(uid: String, completion: @escaping ([Follow], NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection(name).whereField(Follow.uid, isEqualTo: uid).whereField(Follow.isFollow, isEqualTo: true).order(by: createdAt, descending: true).limit(to: 50).getDocuments { (querySnapshot, error) in
            var follows: [Follow] = []
            if let error = error {
                completion([], error as NSError)
                return
            }

            for document in querySnapshot!.documents {
                let follow = Follow(document: document)
                follows.append(follow)
            }
            completion(follows, nil)
        }
    }

    static func featchFollower(uid: String, completion: @escaping ([Follow], NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection(name).whereField(Follow.followUid, isEqualTo: uid).whereField(Follow.isFollow, isEqualTo: true).order(by: createdAt, descending: true).limit(to: 50).getDocuments { (querySnapshot, error) in
            var follows: [Follow] = []
            if let error = error {
                completion([], error as NSError)
                return
            }

            for document in querySnapshot!.documents {
                let follow = Follow(document: document)
                follows.append(follow)
            }
            completion(follows, nil)
        }
    }

    static func follow(uid: String, followUid: String, completion: @escaping (NSError?) -> Void) {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            Follow.uid: uid,
            Follow.followUid: followUid,
            Follow.isFollow: true,
            Follow.createdAt: FieldValue.serverTimestamp()
        ]
        db.collection(Follow.name).addDocument(data: data, completion: { err in
            completion(err as NSError?)
        })
    }

    static func unFollow(uid: String, followUid: String, completion: @escaping (NSError?) -> Void) {
        let db = Firestore.firestore()
        let docsRef = db.collection(Follow.name)
            .whereField(Follow.uid, isEqualTo: uid)
            .whereField(Follow.followUid, isEqualTo: followUid)
            .whereField(Follow.isFollow, isEqualTo: true)
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

    static func isFollow(uid: String, followUid: String, completion: @escaping (Bool, NSError?) -> Void) {
        let db = Firestore.firestore()
        let docsRef = db.collection(Follow.name)
            .whereField(Follow.uid, isEqualTo: uid)
            .whereField(Follow.followUid, isEqualTo: followUid)
            .whereField(Follow.isFollow, isEqualTo: true)
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
