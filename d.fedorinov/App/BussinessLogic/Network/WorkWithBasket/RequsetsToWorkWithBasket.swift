import Foundation
import Alamofire

/** Фабрика которая определяет запросы к API для работы с корзиной */
protocol RequsetsToWorkWithBasketFactory {
    
    func addGoodToBasket(
        idUser: Int,
        idGood: Int,
        quantity: Int,
        completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void)
    
    func deleteGoodFromBasket(
        idUser: Int,
        idGood: Int,
        quantity: Int,
        completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void)
    
    func payOrder(
        idUser: Int,
        completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void)
}
/** Класс в котором создаются и настраиваются запросы к API для работы с корзиной пользователя */
class RequsetsToWorkWithBasket: AbstractRequestFactory, RequsetsToWorkWithBasketFactory {
    
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

