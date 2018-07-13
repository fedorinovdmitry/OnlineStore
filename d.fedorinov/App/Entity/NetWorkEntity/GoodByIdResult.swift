//
//  GoodByIdResult.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 10.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

struct GoodRequest: RequestRouter{
    let baseUrl: URL
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToGetGoodById
    
    let id: Int
    
    var parameters: Parameters? {
        return [
            "id": id
        ]
    }
}
struct GoodByIdResponse: Codable {
    let result: Int
    let good: Good
}
