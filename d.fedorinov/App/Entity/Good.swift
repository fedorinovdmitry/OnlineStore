import Foundation

/** Структура хранящая данные о товаре */
struct Good: Codable{
    let id: Int
    var productName: String
    var productPrice: Int
    var quantity:Int?
    
    init(id: Int, productName: String, productPrice: Int) {
        self.id = id
        self.productName = productName
        self.productPrice = productPrice
    }
}




