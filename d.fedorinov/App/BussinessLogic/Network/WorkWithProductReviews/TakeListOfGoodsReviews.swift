import Foundation
import Alamofire

extension RequsetsToWorkWithProductReviews {
    /** Запрос получения отзыва о товаре */
    /// - parameter idGood: id товара о котором будет получен отзыв
    /// - parameter completionHandler: замыкание в котором обрабатывается ответ от сервера
    func takeGoodsReview(
        idGood: Int,
        completionHandler: @escaping (DataResponse<ResultOfGoodsReviews>) -> Void) {
        let requestModel = ReviewsOfGoodRouter(baseUrl: baseUrl,
                                               idGood: idGood)
        self.request(reques: requestModel,
                     completionHandler: completionHandler)
    }
}
/** Маршрут запроса получения отзыва о товаре */
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
