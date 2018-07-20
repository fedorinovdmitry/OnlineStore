import Foundation
import Alamofire

/** Фабрика которая определяет запросы к API для работы с товарами */
protocol RequestsToWorkWithGoodsFactory {
    
    func takeCatalogDataOfGoods(
        completionHandler: @escaping (DataResponse<[Good]>)
        -> Void)
    /** Запрос получения конкретного товара по ид */
    func takeGood(
        id: Int,
        completionHandler: @escaping (DataResponse<GoodByIdResponse>)
        -> Void)
    
}
/** Класс в котором создаются и настраиваются запросы к API для работы с товарами */
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
