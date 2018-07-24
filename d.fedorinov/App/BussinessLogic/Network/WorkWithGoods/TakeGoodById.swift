import Foundation
import Alamofire

extension RequestsToWorkWithGoods {
    /** Запрос получения конкретного товара по ид */
    /// - parameter id: id получаемого товара
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func takeGood(
        id: Int,
        completionHandler: @escaping (DataResponse<GoodByIdResponse>) -> Void) {
        let requestModel = GoodRequest(baseUrl: baseUrl,
                                       id: id)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса получения конкретного товара по ид */
struct GoodRequest: RequestRouter {
    
    let baseUrl: URL
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToGetGoodById
    
    let id: Int
    
    var parameters: Parameters? {
        return [
            "id": id
        ]
    }
}
