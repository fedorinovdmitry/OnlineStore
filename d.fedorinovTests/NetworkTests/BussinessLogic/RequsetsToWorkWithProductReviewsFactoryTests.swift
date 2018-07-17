import Alamofire
import OHHTTPStubs
import XCTest
@testable import d_fedorinov

class RequsetsToWorkWithProductReviewsFactoryTests: XCTestCase {
    
    var requestsToWorkWithProductReviewsFactory: RequsetsToWorkWithProductReviewsFactory!
    var review: Review!
    
    override func setUp() {
        super.setUp()
        
        let requestFactory = RequestFactoryMock()
        requestsToWorkWithProductReviewsFactory = requestFactory.makeRequsetsToWorkWithProductReviews()
        review = Review(idGood: 110, idUser: 123, textOFReview: "содержание отзыва о товаре")
    }
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
        review = nil
    }
    
    func testAddReview() {
        let expectation = self.expectation(description: "testAddReview")
        
        stubConfig(method: AddReviewRouter.method,
                   path: AddReviewRouter.path,
                   resourceName: "addReview",
                   extensionType:"json")
        
        var addReviewResult: StaticAPIResult?
        requestsToWorkWithProductReviewsFactory.addReview(review: review) { result in
            addReviewResult = result.value
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(addReviewResult)
    }
    
    func testDeleteReview() {
        let expectation = self.expectation(description: "testDeleteReview")
        stubConfig(method: DeleteReviewRouter.method,
                   path: DeleteReviewRouter.path,
                   resourceName: "deleteReview",
                   extensionType:"json")
        
        var deleteReviewResult: StaticAPIResult?
        requestsToWorkWithProductReviewsFactory.deleteReview(review: review) { result in
            deleteReviewResult = result.value
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(deleteReviewResult)
    }
    
    func testTakeListOfGoodsReview() {
        let expectation = self.expectation(description: "testTakeListOfGoodsReview")
        stubConfig(method: ReviewsOfGoodRouter.method,
                   path: ReviewsOfGoodRouter.path,
                   resourceName: "listOfGoodsReview",
                   extensionType:"json")
        
        var takeListOfGoodsReviewResult: ResultOfGoodsReviews?
        requestsToWorkWithProductReviewsFactory.takeGoodsReview(idGood: review.idGood) { result in
            takeListOfGoodsReviewResult = result.value
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(takeListOfGoodsReviewResult)
    }
}
