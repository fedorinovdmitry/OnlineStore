import Foundation
import Alamofire

extension RequestToPersonalAccount {
    func login(username: String,
               password: String,
               completionHandler: @escaping (DataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: username, password: password)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
}

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
