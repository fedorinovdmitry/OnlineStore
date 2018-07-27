import Foundation
import Alamofire

extension RequestToPersonalAccount {
    /// Запрос получения ид для регистрации пользователя
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func takeUserID(completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void) {
        let requestModel = TakeUserIDRouter(baseUrl: baseUrl, parameters: nil)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/// Маршрут запроса получения ид для регистрации пользователя
struct TakeUserIDRouter: RequestRouter {
    
    let baseUrl: URL
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToTakeUserID
    
    var parameters: Parameters? = nil
}
