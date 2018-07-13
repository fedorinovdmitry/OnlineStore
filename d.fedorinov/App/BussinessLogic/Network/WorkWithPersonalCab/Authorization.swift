//
//  Authorization.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 05.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire


extension RequestToPersonalAccount{
    
    func login(username: String, password: String, completionHandler: @escaping (DataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: username, password: password)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
    
    
}

