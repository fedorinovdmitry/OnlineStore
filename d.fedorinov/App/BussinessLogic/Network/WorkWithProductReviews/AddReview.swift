import Foundation
import Alamofire

extension RequsetsToWorkWithProductReviews {
    /** Запрос добавления отзыва о товаре */
    /// - parameter review: отзыв о товаре который будет отправлен
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func addReview(
        review: Review,
        completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void) {
        let requestModel = AddReviewRouter(baseUrl: baseUrl,
                                           review: review)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса добавления отзыва о товаре */
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
