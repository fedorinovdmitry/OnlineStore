import Foundation

struct Good:Codable {
    let id: Int 
    var productName: String
    var productPrice: Int
    var quantity:Int = 1 // по умолчанию количество товара равно 1
    
    init (id:Int, productName: String, productPrice: Int, quantity: Int) {
        self.id = id
        self.productName = productName
        self.productPrice = productPrice
        self.quantity = quantity
    }
    
    init? (_ json: [String:AnyObject]) {
        guard
            let id = json["id"] as? Int,
            let productName = json["productName"] as? String,
            let productPrice = json["productPrice"] as? Int
            else {
                return nil
        }
        self.id = id
        self.productName = productName
        self.productPrice = productPrice
        if let quantity = json["quantity"] as? Int {
            self.quantity = quantity
        }
    }
    
    mutating func setQuantity(quantity: Int){
        self.quantity = quantity
    }
    
    static func getArrayOfGoods() -> [Good] {
        var arr:[Good] = []
        for i in 1...10 {
            arr.append(Good(id: 100 + i, productName: "tovar\(100 + i)", productPrice: 1000 + 1, quantity: Int(arc4random_uniform(UInt32(100))) ))
        }
        return arr
    }
}
extension Good: Equatable {
    static func == (lhs: Good, rhs: Good) -> Bool {
        return lhs.id == rhs.id
    }
}

