import Foundation
import FirebaseFirestore
struct Post {
    let creatorID: String
    let dateCreated: Date?
    let id :String
    let feedImage:String
    let userName:String
    init(creatorID: String, dateCreated: Date? = nil, image:String, userName:String) {
        self.creatorID = creatorID
        self.dateCreated = dateCreated
         self.id = UUID().description
        self.feedImage = image
        self.userName = userName
    }
    init?(from dict: [String: Any], id: String) {
        guard let userID = dict["creatorID"] as? String,
            let image = dict["feedImage"] as? String,
            let userName = dict["userName"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
        self.creatorID = userID
        self.dateCreated = dateCreated
        self.id = id
        self.userName = userName
        self.feedImage = image
    }
    var fieldsDict: [String: Any] {
        return [
            "creatorID": self.creatorID,
            "dateCreated": self.dateCreated,
            "userName": self.userName,
            "feedImage": self.feedImage
        ]
    }
}
