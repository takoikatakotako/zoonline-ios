import UIKit
import Firebase

class Follow {
    static let name = "follow"
    static let uid = "uid"
    static let followUid = "follow_uid"
    static let isFollow = "is_follow"
    static let createdAt = "created_at"

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
