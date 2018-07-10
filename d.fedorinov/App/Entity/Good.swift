//
//  Good.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 09.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation


//struct CatalogOfGoodsResponse: Codable{
//    let pageNumber: Int
//    let products: [GoodFromCatalog]
//
//    enum CodingKeys: String, CodingKey {
//        case pageNumber = "page_number"
//        case products = "products"
//
//    }
//    init(from decoder: Decoder) throws{
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.pageNumber = try! container.decode(Int.self, forKey: .pageNumber)
//        self.products = try! container.decode([GoodFromCatalog].self, forKey: .products)
//    }
//}

//в екселе неправильно описание джсона, верхний вариант для описанного в экселе, по факту же там нету ни категории, ни номера страницы, просто массив товаров у которых еще почему-то в разных запросов разные поля, что мещает сделать одну общую структуру товара
struct GoodFromCatalog: Codable {
    let id: Int
    let productName: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case productName = "product_name"
        case price = "price"
    }
    
}
struct GoodByIdResponse: Codable {
    let result:Int
    let productName:String
    let productPrice:Int
    let productDescription:String
    
    enum CodingKeys: String, CodingKey {
        case result
        case productName = "product_name"
        case productPrice = "product_price"
        case productDescription = "product_description"
    }
    
}
