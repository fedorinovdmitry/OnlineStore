//
//  Deauthorization.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 05.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

extension RequestToPersonalAccount{
    func logOut(id: Int, completionHandler: @escaping (DataResponse<LogOutResult>) -> Void) {
        let requestModel = LogOut(baseUrl: baseUrl, id: id)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
    
}

