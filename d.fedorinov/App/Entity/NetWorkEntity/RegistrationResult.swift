//
//  RegistrationResult.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 10.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

struct Regist: RequestRouter {
    let baseUrl: URL
    static let method: HTTPMethod = .post
    static let path: String = APPURL.wayToRegisterAPI
    var user: User
    var parameters: Parameters? {
        return [
            "id": user.id,
            "username": user.username,
            "password": user.password,
            "email" : user.email,
            "gender": user.gender,
            "creditCard" : user.creditCard,
            "bio" : user.bio
        ]
    }
}
struct RegistrationResult: Codable{
    let result: Int
    let userMessage: String
}

