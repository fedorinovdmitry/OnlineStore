import Foundation
import Alamofire

extension RequestToPersonalAccount{
    /** Запрос регистрации пользователя */
    /// - parameter user: контейнер данных о пользователи, на осове которых он будет зарегистрирован
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func registration(user:User,
                      completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void) {
        let requestModel = RegisterRouter(baseUrl: baseUrl,
                                          user: user)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса регистрации пользователя */
struct RegisterRouter: RequestRouter {
    
    let baseUrl: URL
    static let method: HTTPMethod = .post
    static let path: String = APPURL.wayToRegisterAPI
    
    var user: User
    var parameters: Parameters? {
        return [
            "id": user.id,
            "username": user.username,
            "password": user.password,
            "email" : user.email,
            "gender": user.gender,
            "creditCard" : user.creditCard,
            "bio" : user.bio
        ]
    }
}







