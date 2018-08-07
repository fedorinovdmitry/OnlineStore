
import Foundation

import Crashlytics

enum AnalyticsEvent {
    case login(controller: NSObject,
               success: Bool)
    case logOut
    case signUp(controller: NSObject,
                success: Bool,
                username: String, id: Int)
    case openList
    case openGood(good: Good)
    case addToCart(good: Good)
    case deleteFromCart(good: Good)
    case purchase
    case addReview(review: Review)
}

protocol TrackableMixin {
    func track(_ event: AnalyticsEvent)
}

extension TrackableMixin {
    func track(_ event: AnalyticsEvent) {
        switch event {
        case let .login(controller,
                        success):
            let success = NSNumber(value: success)
            Answers.logLogin(withMethod: controller.theClassName,
                             success: success, customAttributes: nil)
            
        case .logOut:
            Answers.logCustomEvent(withName: "LogOut",
                                   customAttributes: nil)
            
        case let .signUp(controller,
                         success,
                         username,
                         id):
            let success = NSNumber(value: success)
            let attributes:[String:Any] = ["userName": username, "userID": id]
            Answers.logSignUp(withMethod: controller.theClassName,
                              success: success,
                              customAttributes: attributes)
            
        case let .openGood(good):
            Answers.logCustomEvent(withName: "OpenGoodCart",
                                   customAttributes: ["good": good.id])
            
        case let .deleteFromCart(good):
            Answers.logCustomEvent(withName: "DeleteGoodCart",
                                   customAttributes: ["good": good.id])
            
        case .openList:
            Answers.logCustomEvent(withName: "OpenListOfGoods",
                                   customAttributes: nil)
            
        case let .addToCart(good):
            let price = NSDecimalNumber(decimal: Decimal(good.productPrice))
            Answers.logAddToCart(withPrice: price,
                                 currency: "Rub",
                                 itemName: good.productName,
                                 itemType: "default",
                                 itemId: String(good.id),
                                 customAttributes: nil)
            
        case .purchase:
            Answers.logCustomEvent(withName: "PayOrder",
                                   customAttributes: nil)
            
        case let .addReview(review):
            Answers.logCustomEvent(withName: "AddReview",
                                   customAttributes: ["reviewIdUser": review.idUser,
                                                      "reviewIdgood": review.idGood])
        }
    }
}

func assertionFailure(_ message: String,
                      file: StaticString = #file,
                      line: UInt = #line) {
    #if DEBUG
    Swift.assertionFailure(message)
    #else
        Answers.logCustomEvent(
            withName: "AssertionFailure",
            customAttributes: ["message" : message])
    #endif
}

