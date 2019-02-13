import UIKit

class Post: NSObject {
    var id: String!
    var comment: String!

    init(id: String, data: [String: Any]) {
        super.init()

        self.id = id
        if let comment = data["comment"] as? String {
            self.comment = comment
        }
    }

}
