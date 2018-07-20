import Foundation
import Alamofire

extension RequestToPersonalAccount {
    /** Запрос авторизации пользователя */
    /// - parameter username: логин/имя пользователя для авторизации
    /// - parameter password: пароль для авторизации
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func login(username: String,
               password: String,
               completionHandler: @escaping (DataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl,
                                 login: username,
                                 password: password)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса авторизации пользователя */
struct Login: RequestRouter {
    
    let baseUrl: URL
    static let method: HTTPMethod = .post
    static let path: String = APPURL.wayToLoginAPI
    
    let login: String
    let password: String
    var parameters: Parameters? {
        return [
            "username": login,
            "password": password
        ]
    }
}
