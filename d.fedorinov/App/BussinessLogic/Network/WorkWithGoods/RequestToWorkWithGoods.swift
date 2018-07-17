import Foundation
import Alamofire

protocol RequestsToWorkWithGoodsFactory {
    
    func takeCatalogDataOfGoods(
        completionHandler: @escaping (DataResponse<[Good]>)
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
          queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        
    }
    
}
