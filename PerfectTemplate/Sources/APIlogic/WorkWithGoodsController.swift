import Foundation
import PerfectHTTP

var arrOfGoods = Good.getArrayOfGoods()

class WorkWithGoodsController {
    
    let giveGood: (HTTPRequest, HTTPResponse) -> () = { request, response in
        do {
            let arr = request.params()
            guard arr[0].0 == "id" else{
                response.completed(
                    status: HTTPResponseStatus.custom(code: 400, message: "Parse data error dont see id"))
                return
            }
            
            for good in arrOfGoods{
                let idGood = Int(arr[0].1)
                if good.id == idGood ?? -1 {
                    try response.setBody(json: ["result": 1,
                                                "good": ["id": good.id,
                                                         "productName": good.productName,
                                                         "productPrice": good.productPrice,
                                                         "quantity": good.quantity]
                                        ])
                    response.completed()
                    return
                }
            }
            
            response.completed(status: HTTPResponseStatus.custom(code: 404, message: "Dont find such good"))
            
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let giveCatalogOfGoods: (HTTPRequest, HTTPResponse) -> () = { request, response in
        do {
            var jsonDic: [[String:AnyObject]] = []
            for good in arrOfGoods {
                var dic: [String:AnyObject] = [:]
                dic["id"] = good.id as AnyObject
                dic["productName"] = good.productName as AnyObject
                dic["productPrice"] = good.productPrice as AnyObject
                dic["quantity"] = good.quantity as AnyObject
                jsonDic.append(dic)
            }
            try response.setBody(json: jsonDic)
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }

}
