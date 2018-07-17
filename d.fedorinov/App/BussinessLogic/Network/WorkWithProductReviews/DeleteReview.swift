import Foundation
import Alamofire

extension RequsetsToWorkWithProductReviews {
    func deleteReview(
        review: Review,
        completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void) {
        let requestModel = DeleteReviewRouter(baseUrl: baseUrl, review: review)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
}

struct DeleteReviewRouter: RequestRouter {
    let baseUrl: URL
    static let method: HTTPMethod = .post
    static let path: String = APPURL.wayToDeleteReview
    
    var review: Review
    var parameters: Parameters? {
        return [
            "idGood": review.idGood,
            "idUser": review.idUser,
            "text": review.text
        ]
    }
}
