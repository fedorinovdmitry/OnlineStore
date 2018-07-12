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
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToRegisterAPI
    var user: User
    var parameters: Parameters? {
        return [
            "id_user": user.id,
            "username": user.userName,
            "password": user.password,
            "email" : user.email,
            "gender": user.gender,
            "credit_card" : user.creditCard,
            "bio" : user.bio
        ]
    }
}
struct RegistrationResult: Codable{
    let result: Int
    let userMessage: String
}

