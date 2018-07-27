import Foundation
import Alamofire

/** Фабрика пораждающая запросы к API */
class RequestFactory {
    static let instance = RequestFactory()
    private init(){}
    
    func makeErrorParser() -> AbstractErrorParser {
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
    
    func makeRequestToPersonalAccount() -> RequestsToPersonalAccountFactory {
        let errorParser = makeErrorParser()
        return RequestToPersonalAccount(errorParser: errorParser,
                                        sessionManager: commonSessionManager,
                                        queue: sessionQueue)
    }
    func makeRequestToWorkWithGoods() -> RequestsToWorkWithGoodsFactory {
        let errorParser = makeErrorParser()
        return RequestsToWorkWithGoods(errorParser: errorParser,
                                       sessionManager: commonSessionManager,
                                       queue: sessionQueue)
    }
    func makeRequsetsToWorkWithProductReviews() -> RequsetsToWorkWithProductReviewsFactory {
        let errorParser = makeErrorParser()
        return RequsetsToWorkWithProductReviews(errorParser: errorParser,
                                                sessionManager: commonSessionManager,
                                                queue: sessionQueue)
    }
    func makeRequsetsToWorkWithBasket() -> RequsetsToWorkWithBasketFactory {
        let errorParser = makeErrorParser()
        return RequsetsToWorkWithBasket(errorParser: errorParser,
                                                sessionManager: commonSessionManager,
                                                queue: sessionQueue)
    }
}
