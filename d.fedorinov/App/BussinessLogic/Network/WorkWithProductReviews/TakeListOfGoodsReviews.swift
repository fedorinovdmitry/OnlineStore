import Foundation
import Alamofire

extension RequsetsToWorkWithProductReviews {
    func takeGoodsReview(
        idGood: Int,
        completionHandler: @escaping (DataResponse<ResultOfGoodsReviews>) -> Void) {
        let requestModel = ReviewsOfGoodRouter(baseUrl: baseUrl, idGood: idGood)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
}

struct ReviewsOfGoodRouter: RequestRouter {
    let baseUrl: URL
    static let method: HTTPMethod = .get
    static let path: String = APPURL.wayToGetListOfGoodsReview
    
    var idGood: Int
    var parameters: Parameters? {
        return [
            "idGood": idGood
        ]
    }
}
