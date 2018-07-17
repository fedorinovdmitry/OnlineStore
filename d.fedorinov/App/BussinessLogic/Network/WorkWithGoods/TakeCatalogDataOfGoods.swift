import Foundation
import Alamofire

extension RequestsToWorkWithGoods {
    
    func takeCatalogDataOfGoods(completionHandler: @escaping (DataResponse<[Good]>) -> Void) {
        
        let requestModel = CatalogDataRequest(baseUrl: baseUrl, parameters: nil)
        self.request(reques: requestModel, completionHandler: completionHandler)
        
    }
    
}
struct CatalogDataRequest: RequestRouter {
    let baseUrl: URL
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToGetCatalogOfGoods
    var parameters: Parameters?
}
