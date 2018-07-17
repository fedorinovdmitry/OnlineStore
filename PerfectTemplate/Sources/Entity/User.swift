import Foundation

struct User{
    let id: Int
    let username: String
    let password: String
    var email: String = ""
    var gender: String = ""
    var creditCard: String = ""
    var bio: String = ""
    
    init? (_ json: [String:AnyObject]) {
        guard
            let idUser = json["id"] as? Int,
            let username = json["username"] as? String,
            let password = json["password"] as? String
        else{
            return nil
        }
        self.id = idUser
        self.username = username
        self.password = password
        
        if let email = json["email"] as? String {
            self.email = email
        }
        if let gender = json["gender"] as? String {
            self.gender = gender
        }
        if let creditCard = json["creditCard"] as? String {
            self.creditCard = creditCard
        }
        if let bio = json["bio"] as? String {
            self.bio = bio
        }
        
    }
}

extension User: Equatable{
    static func == (lhs: User, rhs: User) -> Bool{
        return lhs.id == rhs.id
    }
}
