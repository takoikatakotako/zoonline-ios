import UIKit
import Firebase

class Follow {
    static let name = "follow"
    static let uid = "uid"
    static let followUid = "follow_uid"
    static let isFollow = "is_follow"
    static let createdAt = "created_at"

    var uid: String
    var followUid: String
    var isFollow: Bool
    var createdAt: Date!

    init(document: DocumentSnapshot) {
        if let uid = document.get(Follow.uid) as? String {
            self.uid = uid
        } else {
            // 本来きてはダメ
            self.uid = ""
        }

        if let followUid = document.get(Follow.followUid) as? String {
            self.followUid = followUid
        } else {
            // 本来きてはダメ
            self.followUid = ""
        }

        if let isFollow = document.get(Follow.isFollow) as? Bool {
            self.isFollow = isFollow
        } else {
            self.isFollow = false
        }

        if let createdAt = document.get(Follow.createdAt) as? Date {
            self.createdAt = createdAt
        }
    }
}
