import Foundation
import Alamofire

extension RequsetsToWorkWithBasket {
    /// Запрос добавления товара в корзину
    /// - parameter idUser: id пользователя которому принаджлежит корзина
    /// - parameter idGood: id товара который будет помещен в корзину
    /// - parameter quantity: количестова данного товара
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func addGoodToBasket(idUser: Int,
                         idGood: Int,
                         quantity: Int,
                         completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void) {
        let requestModel = AddGoodToBasketRouter(baseUrl: baseUrl,
                                                 idUser: idUser,
                                                 idGood: idGood,
                                                 quantity: quantity)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса добавления товара в корзину */
struct AddGoodToBasketRouter: RequestRouter {
    
    let baseUrl: URL
    static let method: HTTPMethod = .post
    static let path: String = APPURL.wayToAddGoodInBasket
    
    var idUser: Int
    var idGood: Int
    var quantity: Int
    
    var parameters: Parameters? {
        return [
            "idUser": self.idUser,
            "idGood": self.idGood,
            "quantity": self.quantity
        ]
    }
}
