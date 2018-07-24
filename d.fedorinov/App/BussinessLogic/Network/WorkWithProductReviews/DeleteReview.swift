import Foundation
import Alamofire

extension RequsetsToWorkWithProductReviews {
    /** Запрос удаления отзыва о товаре */
    /// - parameter review: отзыв о товаре который будет удален
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func deleteReview(
        review: Review,
        completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void) {
        let requestModel = DeleteReviewRouter(baseUrl: baseUrl,
                                              review: review)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса удаления отзыва о товаре */
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
