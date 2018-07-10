//
//  LogOutResult.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 10.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

struct LogOut: RequestRouter {
    let baseUrl: URL
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToLogOutAPI
    
    let id: Int
    
    var parameters: Parameters? {
        return [
            "id_user": id
        ]
    }
}
struct LogOutResult: Codable{
    let result: Int
}
