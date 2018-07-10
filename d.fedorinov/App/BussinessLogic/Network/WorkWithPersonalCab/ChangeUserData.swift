//
//  ChangeUserData.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 05.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

extension RequestToPersonalAccount{
    func changeUserData(user:User,
                        completionHandler: @escaping (DataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeData(baseUrl: baseUrl,
                                      user:user)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
    
    struct ChangeData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = APPURL.wayToChangeUserDataAPI
        
        var user: User
        var parameters: Parameters? {
            return [
                "id_user": user.id,
                "username": user.userName,
                "password": user.password,
                "email" : user.email,
                "gender": user.gender,
                "credit_card" : user.credit_car,
                "bio" : user.bio
            ]
        }
    }
    
}
