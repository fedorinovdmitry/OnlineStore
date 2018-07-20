import Alamofire
import OHHTTPStubs
import XCTest
@testable import d_fedorinov

/// Тесты запросов по работе с корзиной
class RequsetsToWorkWithBasketFactoryTests: XCTestCase {
    
    var requsetsToWorkWithBasketFactory: RequsetsToWorkWithBasketFactory!
    
    override func setUp() {
        super.setUp()
        
        let requestFactory = RequestFactoryMock()
        requsetsToWorkWithBasketFactory = requestFactory.makeRequsetsToWorkWithBasket()
        
    }
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()

    }
    
    func testAddGoodToBasket() {
        let expectation = self.expectation(description: "testAddGoodToBasket")
        
        stubConfig(method: AddGoodToBasketRouter.method,
                   path: AddGoodToBasketRouter.path,
                   resourceName: "addGoodToBasket",
                   extensionType: "json")
        
        var addGoodToBasketResult: StaticAPIResult?
        requsetsToWorkWithBasketFactory.addGoodToBasket(idUser: 123,
                                                        idGood: 110,
                                                        quantity: 2) { result in
            addGoodToBasketResult = result.value
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(addGoodToBasketResult)
    }
    
    func testDeleteGoodFromBasket() {
        let expectation = self.expectation(description: "testDeleteGoodFromBasket")
        
        stubConfig(method: DeleteGoodFromBasketRouter.method,
                   path: DeleteGoodFromBasketRouter.path,
                   resourceName: "deleteGoodFromBasket",
                   extensionType: "json")
        
        var deleteGoodFromBasketResult: StaticAPIResult?
        requsetsToWorkWithBasketFactory.deleteGoodFromBasket(idUser: 123,
                                                             idGood: 110,
                                                             quantity: 2) { result in
            deleteGoodFromBasketResult = result.value
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(deleteGoodFromBasketResult)
    }
    
    func testPayOrder() {
        let expectation = self.expectation(description: "testPayOrder")
        
        stubConfig(method: PayOrderRouter.method,
                   path: PayOrderRouter.path,
                   resourceName: "payOrder",
                   extensionType: "json")
        
        var payOrderResult: StaticAPIResult?
        requsetsToWorkWithBasketFactory.payOrder(idUser: 123) { result in
            payOrderResult = result.value
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(payOrderResult)
    }
}
