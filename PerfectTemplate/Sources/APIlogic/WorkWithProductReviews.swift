import Foundation
import PerfectHTTP

var arrOfReviews: [Review] = []

class WorkWithProductReviewsController {
    
    let addReview: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard
            let str = request.postBodyString,
            let data = str.data(using: .utf8)
            else {
                response.completed(status: HTTPResponseStatus.custom(code: 400, message: "Wrong user data"))
                return
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            guard let registerRequest = Review(json)
                else {
                    try response.setBody(json: ["result": 0, "userMessage": "Отправлены неверные/не все данные!"])
                    response.completed()
                    return
            }
            
            var hasReview = false
            for review in arrOfReviews {
                if review.idGood == registerRequest.idGood && review.idUser == registerRequest.idUser {
                    arrOfReviews = EdditingArray.chageElementsInArray(elementDeleting: review,
                                                                      elementAdding: registerRequest,
                                                                      arrOfElement: arrOfReviews)
                    hasReview = true
                }
            }
            if hasReview == false {
                arrOfReviews.append(registerRequest)
            }
            
            print("addReviewRequest - \(registerRequest)")
            try response.setBody(json: ["result": 1, "userMessage": "Отзыв добавлен"])
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let deleteReview: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard
            let str = request.postBodyString,
            let data = str.data(using: .utf8)
            else {
                response.completed(status: HTTPResponseStatus.custom(code: 400, message: "Wrong user data"))
                return
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            guard let registerRequest = Review(json)
                else {
                    try response.setBody(json: ["result": 0, "userMessage": "Отправлены неверные/не все данные!"])
                    response.completed()
                    return
            }
            
            for review in arrOfReviews {
                if review.idGood == registerRequest.idGood && review.idUser == registerRequest.idUser {
                    arrOfReviews = EdditingArray.deleteElementFromArray(element: review, arrOfElement: arrOfReviews)
                    try response.setBody(json: ["result": 1, "userMessage": "Отзыв удален"])
                    response.completed()
                }
            }
            
            print("deleteReviewRequest - \(registerRequest)")
            try response.setBody(json: ["result": 0, "userMessage": "Отзыв отсутствует"])
            response.completed()
            
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let giveReviewsOfGood: (HTTPRequest, HTTPResponse) -> () = { request, response in
        do {
            guard let idGoodString = request.param(name: "idGood"),
                  let idGood = Int(idGoodString)
                else {
                response.completed(
                    status: HTTPResponseStatus.custom(code: 400, message: "Parse data error dont see idGood"))
                return
            }
            var arrOfGoodReviews: [Review] = []
            var hasReview = false
            for review in arrOfReviews {
                if review.idGood == idGood {
                    arrOfGoodReviews.append(review)
                    hasReview = true
                }
            }
            if hasReview == false {
                response.completed(status: HTTPResponseStatus.custom(code: 404, message: "Dont find review for this good"))
            }
            var json:[String:AnyObject] = [:]
            json["result"] = arrOfGoodReviews.count as AnyObject
            
            var jsonDic: [[String:AnyObject]] = []
            for review in arrOfGoodReviews {
                var dic: [String:AnyObject] = [:]
                dic["idGood"] = review.idGood as AnyObject
                dic["idUser"] = review.idUser as AnyObject
                dic["text"] = review.text as AnyObject
                jsonDic.append(dic)
            }
            
            json["reviews"] = jsonDic as AnyObject
            try response.setBody(json: json)
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
}
