//
//  Deauthorization.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 05.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

class Deauthorization: AbstractRequestFactory {
    
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

extension Deauthorization: DeauthRequestFactory{
    struct LogOut: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        
        let id_user: Int
        
        var parameters: Parameters? {
            return [
                "id_user": id_user
            ]
        }
    }
    func logOut(id_user: Int, completionHandler: @escaping (DataResponse<LogOutResult>) -> Void) {
        let requestModel = LogOut(baseUrl: baseUrl, id_user: id_user)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
}
