import UIKit

class Post {
    static let name = "post"
    static let uid = "uid"
    static let postId = "post_id"
    static let comment = "comment"
    static let createdAt = "created_at"
    var id: String!
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

    init() {
    }

    init(id: String, data: [String: Any]) {
        self.id = id
        if let uid = data[Post.uid] as? String {
            self.uid = uid
        }
        if let comment = data[Post.comment] as? String {
            self.comment = comment
        }
        if let createdAt = data[Post.createdAt] as? Date {
            self.createdAt = createdAt
        }
    }

    static func getPostImagePath(postId: String) -> String {
        return "post/" + postId + "/image.png"
    }
}
