//
//  GoodFromCatalogResult.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 10.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

struct CatalogDataRequest: RequestRouter{
    let baseUrl: URL
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToGetCatalogOfGoods
    let pageNumber:Int
    let idCategory:Int
    var parameters: Parameters? {
        return [
            "page_number": pageNumber,
            "id_category": idCategory
        ]
    }
    
}



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
