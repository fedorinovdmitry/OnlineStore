//
//  ChangeUserResult.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 10.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

struct ChangeData: RequestRouter {
    let baseUrl: URL
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToChangeUserDataAPI
    
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
struct ChangeUserDataResult: Codable{
    let result: Int
}
