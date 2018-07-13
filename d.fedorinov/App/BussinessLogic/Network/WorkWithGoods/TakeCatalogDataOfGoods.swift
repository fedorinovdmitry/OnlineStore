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
    
    func takeCatalogDataOfGoods(
        completionHandler: @escaping (DataResponse<[Good]>) -> Void) {
        let requestModel = CatalogDataRequest(baseUrl: baseUrl, parameters: nil)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
    
}

