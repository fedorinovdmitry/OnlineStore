import Foundation
import Alamofire

extension RequestsToWorkWithGoods {
    /** Запрос получения каталога товаров */
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func takeCatalogDataOfGoods(completionHandler: @escaping (DataResponse<[Good]>) -> Void) {
        let requestModel = CatalogDataRequest(baseUrl: baseUrl, parameters: nil)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса получения каталога товара */
struct CatalogDataRequest: RequestRouter {
    
    let baseUrl: URL
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToGetCatalogOfGoods
    var parameters: Parameters? = nil
}
