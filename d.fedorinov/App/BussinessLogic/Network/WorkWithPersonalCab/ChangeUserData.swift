import Foundation
import Alamofire

extension RequestToPersonalAccount {
    /** Запрос изменения данных пользователя */
    /// - parameter user: контейнер изменненых данных о пользователе
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func changeUserData(user:User,
                        completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void) {
        let requestModel = ChangeData(baseUrl: baseUrl,
                                      user:user)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/**
 * Маршрут запроса изменения данных пользователя */
struct ChangeData: RequestRouter {
    
    let baseUrl: URL
    static let method: HTTPMethod = .post
    static let path: String = APPURL.wayToChangeUserDataAPI
    
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
