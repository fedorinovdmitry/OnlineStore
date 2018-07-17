import Foundation
import Alamofire

extension RequsetsToWorkWithProductReviews {
    func addReview(
        review: Review,
        completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void) {
        let requestModel = AddReviewRouter(baseUrl: baseUrl, review: review)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
}

struct AddReviewRouter: RequestRouter {
    let baseUrl: URL
    static let method: HTTPMethod = .post
    static let path: String = APPURL.wayToAddReview
    
    var review: Review
    var parameters: Parameters? {
        return [
            "idGood": review.idGood,
            "idUser": review.idUser,
            "text": review.text
        ]
    }
}
