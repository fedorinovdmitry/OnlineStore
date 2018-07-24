import Foundation
import Alamofire

/** Фабрика которая определяет запросы к API для работы с личным аккаунтом пользователя */
protocol RequestsToPersonalAccountFactory {
    
    func login(
        username: String,
        password: String,
        completionHandler: @escaping (DataResponse<LoginResult>)
        -> Void)
    
    func logOut(
        id: Int,
        completionHandler: @escaping (DataResponse<StaticAPIResult>)
        -> Void)
    
    func registration(
        user: User,
        completionHandler: @escaping (DataResponse<StaticAPIResult>)
        -> Void)
    
    func changeUserData(
        user: User,
        completionHandler: @escaping (DataResponse<StaticAPIResult>)
        -> Void)
}
/** Класс в котором создаются и настраиваются запросы к API для работы с личным аккаунтом пользователя */
class RequestToPersonalAccount: AbstractRequestFactory, RequestsToPersonalAccountFactory {
    
    var errorParser: AbstractErrorParser
    var sessionManager: SessionManager
    var queue: DispatchQueue?
    let baseUrl = URL(string: APPURL.baseUrlToAPI)!
    
    init (errorParser: AbstractErrorParser,
          sessionManager: SessionManager,
          queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}





