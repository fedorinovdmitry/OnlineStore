//
//  ResponseCodableTests.swift
//  d.fedorinovTests
//
//  Created by Дмитрий Федоринов on 10.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//
import Alamofire
import XCTest
@testable import d_fedorinov


struct PostStub:Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}




class ResponseCodableTests: XCTestCase {
    var errorParser: ErrorParserStub!
    
    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
    }
    
    override func tearDown() {
        super.tearDown()
        errorParser = nil
    }
    
    func testShouldDownloadAndParse(){
        
        let expectation = self.expectation(description: "")
        var post: PostStub?
        Alamofire.request("https://jsonplaceholder.typicode.com/posts/1").responseCodable(errorParser: errorParser){ (response: DataResponse<PostStub>) in
            post = response.value
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        XCTAssertNotNil(post)
        
        
    }
    
}

