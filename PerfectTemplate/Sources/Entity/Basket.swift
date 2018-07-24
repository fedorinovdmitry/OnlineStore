import Foundation

class Basket {
    let idUser: Int
    var arrOfGoods: [Good]
    
    init (idUser: Int, arrOfGoods: [Good]) {
        self.idUser = idUser
        self.arrOfGoods = arrOfGoods
    }
    func append(good:Good) {
        self.arrOfGoods.append(good)
    }
    func delete(good:Good) {
        self.arrOfGoods = EdditingArray.deleteElementFromArray(element: good, arrOfElement: self.arrOfGoods)
    }
}

extension Basket: Equatable {
    static func == (lhs: Basket, rhs: Basket) -> Bool{
        return lhs.idUser == rhs.idUser && lhs.idUser == rhs.idUser
    }
}
