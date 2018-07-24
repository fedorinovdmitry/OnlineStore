import Foundation

/** Структура хранящая данные пользователя */
struct User: Codable{
    let id: Int
    var username: String
    var password: String
    var email: String
    var gender: String
    var creditCard: String
    var bio: String
    
    init(id:Int,
         username:String,
         password:String,
         email:String,
         gender: String,
         creditCard: String,
         bio: String) {
        
        self.id = id
        self.username = username
        self.password = password
        self.email = email
        self.gender = gender
        self.creditCard = creditCard
        self.bio = bio
    }
    
}


