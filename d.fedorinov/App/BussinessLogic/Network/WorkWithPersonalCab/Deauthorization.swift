import Foundation
import Alamofire

extension RequestToPersonalAccount {
    /** Запрос деавторизации пользователя */
    /// - parameter id: id пользователя который будет деавторизован
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func logOut(id: Int,
                completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void) {
        let requestModel = LogOut(baseUrl: baseUrl,
                                  id: id)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса деавторизации пользователя */
struct LogOut: RequestRouter {
    
    let baseUrl: URL
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToLogOutAPI
    
    let id: Int
    
    var parameters: Parameters? {
        return [
            "id": id
        ]
    }
}
