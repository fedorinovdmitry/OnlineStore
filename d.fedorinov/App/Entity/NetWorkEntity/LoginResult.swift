//
//  LoginResult.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 10.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

struct Login: RequestRouter {
    let baseUrl: URL
    static let method: HTTPMethod = .post
    static let path: String = APPURL.wayToLoginAPI
    
    let login: String
    let password: String
    var parameters: Parameters? {
        return [
            "username": login,
            "password": password
        ]
    }
}
struct LoginResult: Codable{
    let result: Int
    let user: User
    let authToken: String
}
