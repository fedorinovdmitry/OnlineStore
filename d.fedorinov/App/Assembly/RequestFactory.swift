//
//  RequestFactory.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 05.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation
import Alamofire

class RequestFactory {
    func makeErrorParser() -> AbstractErrorParser{
        return ErrorParser()
    }
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let manager = SessionManager(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Authorization(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    func makeDeauthRequestFactory() -> DeauthRequestFactory{
        let errorParser = makeErrorParser()
        return Deauthorization(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    func makeRegistrationRequestFactory() -> RegistrationRequestFactory{
        let errorParser = makeErrorParser()
        return Registration(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    func makeChangeUserDataRequestFactory() -> ChangeUserDataRequestFactory{
        let errorParser = makeErrorParser()
        return ChangeUserData(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
}
