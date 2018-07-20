import Alamofire
import OHHTTPStubs
@testable import d_fedorinov

/// Фабрика пораждающая моковые запросы
class RequestFactoryMock {
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParserStub()
    }
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.ephemeral //эфемерная сесия ничего не хранит
        OHHTTPStubs.isEnabled(for: configuration)
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
