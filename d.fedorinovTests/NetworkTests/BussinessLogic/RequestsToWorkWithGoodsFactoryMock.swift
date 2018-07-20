import Alamofire
import OHHTTPStubs
import XCTest
@testable import d_fedorinov

/// Тесты запросов по работе с товарами
class RequestsToWorkWithGoodsFactoryTests: XCTestCase {
    
    var requestsToWorkWithGoodsFactory: RequestsToWorkWithGoodsFactory!
    
    override func setUp() {
        super.setUp()
        
        let requestFactory = RequestFactoryMock()
        requestsToWorkWithGoodsFactory = requestFactory.makeRequestToWorkWithGoods()
        
    }
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
        
    }
    
    func testTakeCatalogDataOfGoods() {
        let expectation = self.expectation(description: "testTakeCatalogDataOfGoods")
        stubConfig(method: CatalogDataRequest.method,
                   path: CatalogDataRequest.path,
                   resourceName: "catalogData",
                   extensionType:"json")
        
        var goodsFromCatalogResult: [Good]?
        requestsToWorkWithGoodsFactory.takeCatalogDataOfGoods() { result in
            goodsFromCatalogResult = result.value
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(goodsFromCatalogResult)
    }
    
    func testTakeGood() {
        let expectation = self.expectation(description: "testTakeGood")
        stubConfig(method: GoodRequest.method,
                   path: GoodRequest.path,
                   resourceName: "getGoodById",
                   extensionType:"json")
        
        var goodByIdResult: GoodByIdResponse?
        requestsToWorkWithGoodsFactory.takeGood(id: 100) { result in
            goodByIdResult = result.value
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(goodByIdResult)
    }
}
