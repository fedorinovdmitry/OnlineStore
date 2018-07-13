//
//  RequestsToPersonalAccountFactoryMock.swift
//  d.fedorinovTests
//
//  Created by Дмитрий Федоринов on 10.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//


import Alamofire
import OHHTTPStubs
import XCTest
@testable import d_fedorinov

class RequestsToPersonalAccountFactoryTests: XCTestCase {
    
    var requestsToPersonalAccountFactory: RequestsToPersonalAccountFactory!
    var user: User!
    override func setUp() {
        super.setUp()
        
        let requestFactory = RequestFactoryMock()
        requestsToPersonalAccountFactory = requestFactory.makeRequestToPersonalAccount()
        user = User(id: 123,
                    username: "Somebody",
                    password: "mypassword",
                    email: "some@some.ru",
                    gender: "m",
                    creditCard: "9872389-2424-234224-234",
                    bio: "This is good! I think I will switch to another language")
    }
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
        user = nil
    }
    
    func testLogin() {
        let expectation = self.expectation(description: "testLogin")
        stubConfig(method: Login.method, path: Login.path, resourceName: "login", extensionType:"json")
        
        var loginResult: LoginResult?
        requestsToPersonalAccountFactory.login(
            username: user.username,
            password: user.password){ result in
                loginResult = result.value
                expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(loginResult)
        
    }
    func testLogout() {
        let expectation = self.expectation(description: "testLogout")
        stubConfig(method: LogOut.method, path: LogOut.path, resourceName: "logout", extensionType:"json")
        
        var logOutResult: LogOutResult?
        requestsToPersonalAccountFactory.logOut(id: user.id){ result in
            logOutResult = result.value
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(logOutResult)
        
    }
    func testRegistration() {
        let expectation = self.expectation(description: "testRegistration")
        stubConfig(method: Regist.method, path: Regist.path, resourceName: "registerUser", extensionType:"json")
        
        var registrationResult: RegistrationResult?
        requestsToPersonalAccountFactory.registration(user: user){result in
            registrationResult = result.value
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(registrationResult)
        
    }
    func testChangeUserData() {
        let expectation = self.expectation(description: "testChangeUserData")
        stubConfig(method: ChangeData.method, path: ChangeData.path, resourceName: "changeUserData", extensionType:"json")
        var changeUserDataResult: ChangeUserDataResult?
        requestsToPersonalAccountFactory.changeUserData(user: user){result in
            changeUserDataResult = result.value
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(changeUserDataResult)
    }
}

