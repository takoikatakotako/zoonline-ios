import UIKit
import Firebase

class FollowHandler: Follow {

    static func featchFollowees(uid: String, completion: @escaping ([Follow], NSError?) -> Void) {
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
}
