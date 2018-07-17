import Foundation

struct Good {
    let id: Int 
    var productName: String
    var productPrice: Int
    
    init (id:Int, productName: String, productPrice: Int) {
        self.id = id
        self.productName = productName
        self.productPrice = productPrice
    }
    
    init? (_ json: [String:AnyObject]) {
        guard
            let id = json["id"] as? Int,
            let productName = json["productName"] as? String,
            let productPrice = json["productPrice"] as? Int
            else{
                return nil
        }
        self.id = id
        self.productName = productName
        self.productPrice = productPrice
        
    }
    static func getArrayOfGoods() -> [Good] {
        var arr:[Good] = []
        for i in 1...10 {
            arr.append(Good(id: 100 + i, productName: "tovar\(100 + i)", productPrice: 1000 + 1))
        }
        return arr
    }
}
extension Good: Equatable {
    static func == (lhs: Good, rhs: Good) -> Bool {
        return lhs.id == rhs.id
    }
}

