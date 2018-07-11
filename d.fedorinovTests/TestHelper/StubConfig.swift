//
//  stubConfig.swift
//  d.fedorinovTests
//
//  Created by Дмитрий Федоринов on 10.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//


import Alamofire
import OHHTTPStubs
@testable import d_fedorinov

func stubConfig(method: HTTPMethod, path:String, resourceName:String, extensionType:String){
    
    var condition = isMethodGET()
    switch method {
    case .post:
        condition = isMethodPOST()
    case .patch:
        condition = isMethodPATCH()
    case .delete:
        condition = isMethodDELETE()
    case .put:
        condition = isMethodPUT()
    default:
        break
    }
    stub(condition: condition && pathEndsWith(path)) { request in
        let fileUrl = Bundle.main.url(forResource: resourceName, withExtension: extensionType)!
        return OHHTTPStubsResponse(fileURL: fileUrl, statusCode: 200, headers: nil)
    }
}
