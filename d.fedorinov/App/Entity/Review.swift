import Foundation

struct Review: Codable {
    let idGood: Int
    let idUser: Int
    var text: String
    
    init (idGood:Int, idUser: Int, textOFReview: String) {
        self.idGood = idGood
        self.idUser = idUser
        self.text = textOFReview
    }
}
