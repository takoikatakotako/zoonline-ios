import UIKit

class PostDetailView: UIView {
    
    // UserInfo
    var userThumbnail:UIImageView!
    var usetName:UILabel!
    
    // Follow Info
    var followButton:UIButton!
    var followLabel:UILabel!
    
    // Image
    var postImage:UIImageView!
    
    // Favorite
    var favoriteButton:UIButton!
    var favoriteLabel:UILabel!
    
    // Comment
    var commentButton:UIButton!
    var commentLabel:UILabel!
    
    // Menu
    var menuButton:UIButton!
    
    // Date
    var dateLabel:UILabel!
    
    // Detail
    var detailTextView:UITextView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .orange
        
        // UserInfo
        userThumbnail = UIImageView()
        userThumbnail.image = UIImage(named: "tab-icon-sample")
        userThumbnail.backgroundColor = .red
        addSubview(userThumbnail)
        
        usetName = UILabel()
        usetName.text = "Hello"
        usetName.backgroundColor = .yellow
        usetName.textAlignment = .center
        addSubview(usetName)
        
        // Image
        postImage = UIImageView()
        postImage.image = UIImage(named: "tab-icon-sample")
        postImage.backgroundColor = .red
        addSubview(postImage)
        
        // Favorite
        favoriteButton = UIButton()
        addSubview(favoriteButton)
        
        favoriteLabel = UILabel()
        addSubview(favoriteLabel)
        
        // Comment
        commentButton = UIButton()
        addSubview(commentButton)
        
        commentLabel = UILabel()
        addSubview(commentLabel)
        
        // Menu
        menuButton = UIButton()
        addSubview(menuButton)
        
        // Date
        dateLabel = UILabel()
        addSubview(dateLabel)
        
        // Detail
        detailTextView = UITextView()
        addSubview(detailTextView)
    }
    
    override func layoutSubviews() {
        // let viewWidth = frame.width
        // let viewHeight = frame.height
        // UserInfo
        userThumbnail.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        usetName.frame = CGRect(x: 40, y: 0, width: 200, height: 100)
        
        // Image
        postImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        // Favorite

    }
}
