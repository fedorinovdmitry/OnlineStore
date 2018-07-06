//
//  AbstractRequestFactory.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 05.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

protocol AbstractRequestFactory {
    var errorParser: AbstractErrorParser { get }
    var sessionManager: SessionManager { get }
    var queue: DispatchQueue? { get }
    
    @discardableResult
    func request<T: Decodable>(
        reques: URLRequestConvertible,
        completionHandler: @escaping (DataResponse<T>) -> Void) -> DataRequest
}
extension AbstractRequestFactory{
    @discardableResult
    public func request <T: Decodable>(
        reques: URLRequestConvertible,
        completionHandler: @escaping (DataResponse<T>) -> Void) -> DataRequest {
        return sessionManager.request(reques).responseCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
    }
}
