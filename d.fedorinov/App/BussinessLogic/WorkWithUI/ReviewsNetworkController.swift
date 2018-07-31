import UIKit

protocol ReviewsNetworkControllerDelegate {
    var delegateReviewNetworkController: ReviewsNetworkControllerRequestsFactory { get set }
}

protocol ReviewsNetworkControllerRequestsFactory {
    func takeReviews(idGood: Int, completionHandler: @escaping ([Review]) -> Void)
    func sendReview(review: Review, completionHandler: @escaping (Int) -> Void)
}

typealias ReviewsNetworkUIViewControllerDelegate = UIViewController & ReviewsNetworkControllerDelegate

///Выполняет логику работы с сетью по запросам работаюшими с отзывами для View контроллеров
class ReviewsNetworkController: ReviewsNetworkControllerRequestsFactory {
    
    
    //MARK: - Constants
    
    private let controller: ReviewsNetworkUIViewControllerDelegate
    private let requestFactoryToWorkWithReviews = RequestFactory.instance.makeRequsetsToWorkWithProductReviews()
    
    
    //MARK: - Init
    
    init(controller: ReviewsNetworkUIViewControllerDelegate) {
        self.controller = controller
    }
    
    
    //MARK: - Public methods
    
    func takeReviews(idGood: Int, completionHandler: @escaping ([Review]) -> Void) {
        
        requestFactoryToWorkWithReviews.takeGoodsReview(idGood: idGood) { response in
            switch response.result {
            case .success(let reviewAnswer):
                DispatchQueue.main.async {
                    completionHandler(reviewAnswer.reviews)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sendReview(review: Review, completionHandler: @escaping (Int) -> Void) {
        
        requestFactoryToWorkWithReviews.addReview(review: review) { response in
            switch response.result {
            case .success(let reviewAnswer):
                print(reviewAnswer)
                DispatchQueue.main.async {
                    completionHandler(reviewAnswer.result)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
