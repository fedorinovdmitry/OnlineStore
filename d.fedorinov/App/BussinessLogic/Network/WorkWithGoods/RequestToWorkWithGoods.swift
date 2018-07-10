//
//  RequestToWorkWithGoods.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 09.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestsToWorkWithGoodsFactory {
    func takeCatalogDataOfGoods(
        completionHandler: @escaping (DataResponse<[GoodFromCatalog]>)
        -> Void)
    func takeGood(
        id: Int,
        completionHandler: @escaping (DataResponse<GoodByIdResponse>)
        -> Void)
}
class RequestsToWorkWithGoods: AbstractRequestFactory, RequestsToWorkWithGoodsFactory {
    
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
