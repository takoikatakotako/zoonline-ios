import UIKit

class Post {
    var id: String!
    var comment: String!
    var createdAt: Date!

    init() {
    }

    init(id: String, data: [String: Any]) {
        self.id = id
        if let comment = data["comment"] as? String {
            self.comment = comment
        }
        if let createdAt = data["created_at"] as? Date {
            self.createdAt = createdAt
        }
    }
}
