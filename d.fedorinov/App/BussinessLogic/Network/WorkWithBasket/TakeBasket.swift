import Foundation
import Alamofire

extension RequsetsToWorkWithBasket {
    /// Запрос получения корзины
    /// - parameter idUser: id пользователя которому принаджлежит корзина
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func takeBasket(idUser: Int,
                    completionHandler: @escaping (DataResponse<[Good]>) -> Void) {
        let requestModel = TakeBasketRouter(baseUrl: baseUrl,
                                            idUser: idUser)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса получения корзины */
struct TakeBasketRouter: RequestRouter {
    
    let baseUrl: URL
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToTakeBasket
    
    var idUser: Int
    
    var parameters: Parameters? {
        return [
            "idUser": self.idUser,
        ]
    }
}
