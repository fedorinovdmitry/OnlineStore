import Foundation
import Alamofire

extension RequestsToWorkWithGoods {
    func takeGood(
        id: Int,
        completionHandler: @escaping (DataResponse<GoodByIdResponse>) -> Void) {
        let requestModel = GoodRequest(baseUrl: baseUrl, id: id)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
}

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
