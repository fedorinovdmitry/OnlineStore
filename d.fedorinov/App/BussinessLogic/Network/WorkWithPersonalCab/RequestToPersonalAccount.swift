//
//  RequestToPersonalAccount.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 06.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestsToPersonalAccountFactory {
    func login(
        username: String,
        password: String,
        completionHandler: @escaping (DataResponse<LoginResult>)
        -> Void)
    func logOut(
        id: Int,
        completionHandler: @escaping (DataResponse<LogOutResult>)
        -> Void)
    func registration(
        user: User,
        completionHandler: @escaping (DataResponse<RegistrationResult>)
        -> Void)
    func changeUserData(
        user:User,
        completionHandler: @escaping (DataResponse<ChangeUserDataResult>)
        -> Void)
    
}
class RequestToPersonalAccount: AbstractRequestFactory, RequestsToPersonalAccountFactory {
    
    var errorParser: AbstractErrorParser
    var sessionManager: SessionManager
    var queue: DispatchQueue?
    let baseUrl = URL(string: APPURL.baseUrlToAPI)!
    init (errorParser: AbstractErrorParser,
          sessionManager: SessionManager,
          queue: DispatchQueue? = DispatchQueue.global(qos: .utility)){
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
    
}





