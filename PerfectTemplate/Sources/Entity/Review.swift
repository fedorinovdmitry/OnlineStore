import Foundation

struct Review {
    let idGood: Int
    let idUser: Int
    var text: String

    init (idGood:Int, idUser: Int, textOFReview: String) {
        self.idGood = idGood
        self.idUser = idUser
        self.text = textOFReview
    }
    
    init? (_ json: [String:AnyObject]) {
        guard
            let idGood = json["idGood"] as? Int,
            let idUser = json["idUser"] as? Int,
            let textOfReview = json["text"] as? String
            else{
                return nil
        }
        self.idGood = idGood
        self.idUser = idUser
        self.text = textOfReview
        
    }
}

extension Review: Equatable {
    static func == (lhs: Review, rhs: Review) -> Bool{
        return lhs.idGood == rhs.idGood && lhs.idUser == rhs.idUser
    }
}
