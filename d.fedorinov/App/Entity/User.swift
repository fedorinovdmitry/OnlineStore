//
//  User.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 05.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation

struct LoginResult: Codable{
    let result: Int
    let user: User
}
struct LogOutResult: Codable{
    let result: Int
}
struct RegistrationResult: Codable{
    let result: Int
    let userMessage: String
}
struct ChangeUserDataResult: Codable{
    let result: Int
}
struct User: Codable{
    let id: Int
    let login: String
    let name: String
    let lastname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case name = "user_name"
        case lastname = "user_lastname"
    }
}
