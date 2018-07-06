//
//  ChangeUserData.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 05.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

class ChangeUserData: AbstractRequestFactory {
    
    var errorParser: AbstractErrorParser
    var sessionManager: SessionManager
    var queue: DispatchQueue?
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    init (errorParser: AbstractErrorParser,
          sessionManager: SessionManager,
          queue: DispatchQueue? = DispatchQueue.global(qos: .utility)){
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
    
}

extension ChangeUserData: ChangeUserDataRequestFactory{
    
    func changeUserData(id_user: Int,
                        userName: String,
                        password: String,
                        email: String,
                        gender: String,
                        credit_card: String,
                        bio: String,
                        completionHandler: @escaping (DataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeData(baseUrl: baseUrl,
                                  id_user: id_user,
                                  login: userName,
                                  password: password,
                                  email: email,
                                  gender: gender,
                                  credit_card: credit_card,
                                  bio: bio)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
    
    struct ChangeData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        
        let id_user: Int
        let login: String
        let password: String
        let email: String
        let gender: String
        let credit_card: String
        let bio: String
        var parameters: Parameters? {
            return [
                "id_user": id_user,
                "username": login,
                "password": password,
                "email" : email,
                "gender": gender,
                "credit_card" : credit_card,
                "bio" : bio
            ]
        }
    }
    
}
