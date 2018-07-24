import Foundation
import Alamofire

extension RequsetsToWorkWithBasket {
    /** Запрос оплаты заказа на основе корзины */
    /// - parameter idUser: id пользователя которому принаджлежит корзина
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func payOrder(idUser: Int,
                  completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void) {
        let requestModel = PayOrderRouter(baseUrl: baseUrl,
                                          idUser: idUser)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса оплаты заказа на основе корзины */
struct PayOrderRouter: RequestRouter {
    
    let baseUrl: URL
    static let method: HTTPMethod = .post
    static let path: String = APPURL.wayToPayOrder
    
    var idUser: Int
    
    var parameters: Parameters? {
        return [
            "idUser": self.idUser,
        ]
    }
}
