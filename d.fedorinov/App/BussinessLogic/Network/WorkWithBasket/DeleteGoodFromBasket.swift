import Foundation
import Alamofire

extension RequsetsToWorkWithBasket {
    /// Запрос удаления товара из корзины
    /// - parameter idUser: id пользователя которому принаджлежит корзина
    /// - parameter idGood: id товара который будет удален из корзины
    /// - parameter quantity: количестова данного товара
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func deleteGoodFromBasket(idUser: Int,
                              idGood: Int,
                              quantity: Int,
                              completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void) {
        let requestModel = DeleteGoodFromBasketRouter(baseUrl: baseUrl,
                                                      idUser: idUser,
                                                      idGood: idGood,
                                                      quantity: quantity)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса удаления товара из корзины */
struct DeleteGoodFromBasketRouter: RequestRouter {
    
    let baseUrl: URL
    static let method: HTTPMethod = .post
    static let path: String = APPURL.wayToDeleteGoodFromBasket
    
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
