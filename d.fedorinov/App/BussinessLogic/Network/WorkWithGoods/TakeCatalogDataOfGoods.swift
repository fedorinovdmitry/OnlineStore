//
//  TakeCatalogDataOfGoods.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 09.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire
extension RequestsToWorkWithGoods{
    
    func takeCatalogDataOfGoods(completionHandler: @escaping (DataResponse<[GoodFromCatalog]>) -> Void) {
        let requestModel = CatalogDataRequest(baseUrl: baseUrl)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
    struct CatalogDataRequest: RequestRouter{
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = APPURL.wayToGetCatalogOfGoods
        let parameters: Parameters? = nil
    }
}
