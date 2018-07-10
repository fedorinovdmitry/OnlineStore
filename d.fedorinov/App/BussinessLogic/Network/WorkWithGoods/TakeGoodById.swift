//
//  TakeGoodById.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 09.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire
extension RequestsToWorkWithGoods{
    
    func takeGood(id: Int, completionHandler: @escaping (DataResponse<GoodByIdResponse>) -> Void) {
        let requestModel = GoodRequest(baseUrl: baseUrl, id: id)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
    struct GoodRequest: RequestRouter{
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = APPURL.wayToGetGoodById
        
        let id: Int
        
        var parameters: Parameters? {
            return [
                "id_product": id
            ]
        }
        
        
    }
}
