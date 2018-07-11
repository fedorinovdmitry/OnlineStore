//
//  RequestRouter.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 05.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

enum RequestRouterEncoding{
    case url,json
}
protocol RequestRouter: URLRequestConvertible {
    var baseUrl: URL { get }
    static var method: HTTPMethod { get }
    static var path: String { get }
    var parameters: Parameters? { get }
    var fullUrl: URL { get }
    var encoding: RequestRouterEncoding { get }
    
}
extension RequestRouter {
    var fullUrl: URL {
        return baseUrl.appendingPathComponent(Self.path)
    }
    var encoding: RequestRouterEncoding {
        return .url
    }
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = Self.method.rawValue
        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
