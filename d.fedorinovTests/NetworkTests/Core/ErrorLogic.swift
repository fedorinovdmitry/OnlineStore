//
//  ErrorLogic.swift
//  d.fedorinovTests
//
//  Created by Дмитрий Федоринов on 10.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Alamofire
@testable import d_fedorinov

enum ApiErrorStub: Error{
    case fatalError
}
struct ErrorParserStub:AbstractErrorParser{
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
    
    
}
