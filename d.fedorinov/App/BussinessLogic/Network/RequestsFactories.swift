//
//  RequestsFactories.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 05.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(
        userName: String,
        password: String,
        completionHandler: @escaping (DataResponse<LoginResult>)
        -> Void)
}
protocol DeauthRequestFactory {
    func logOut(
        id_user: Int,
        completionHandler: @escaping (DataResponse<LogOutResult>)
        -> Void)
}
protocol RegistrationRequestFactory {
    func registration(
        id_user: Int,
        userName: String,
        password: String,
        email: String,
        gender: String,
        credit_card: String,
        bio: String,
        completionHandler: @escaping (DataResponse<RegistrationResult>)
        -> Void)
}

protocol ChangeUserDataRequestFactory {
    func changeUserData(
        id_user: Int,
        userName: String,
        password: String,
        email: String,
        gender: String,
        credit_card: String,
        bio: String,
        completionHandler: @escaping (DataResponse<ChangeUserDataResult>)
        -> Void)
    
}
