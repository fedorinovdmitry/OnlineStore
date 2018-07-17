import Foundation

struct Good: Codable{
    let id: Int
    var productName: String
    var productPrice: Int
    
    init(id: Int, productName: String, productPrice: Int) {
        self.id = id
        self.productName = productName
        self.productPrice = productPrice
    }
}




