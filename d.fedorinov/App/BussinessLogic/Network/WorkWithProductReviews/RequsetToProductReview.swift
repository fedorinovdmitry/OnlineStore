import Foundation
import Alamofire

/** Фабрика которая определяет запросы к API для работы с отзывами */
protocol RequsetsToWorkWithProductReviewsFactory {
    
    func addReview(
        review: Review,
        completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void)
    
    func deleteReview(
        review: Review,
        completionHandler: @escaping (DataResponse<StaticAPIResult>) -> Void)
    
    func takeGoodsReview(
        idGood: Int,
        completionHandler: @escaping (DataResponse<ResultOfGoodsReviews>) -> Void)
}
/** Класс в котором создаются и настраиваются запросы к API для работы с отзывами к товару */
class RequsetsToWorkWithProductReviews: AbstractRequestFactory, RequsetsToWorkWithProductReviewsFactory {
    
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

