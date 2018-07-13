//
//  WorkWithGoodsController.swift
//  PerfectTemplate
//
//  Created by Дмитрий Федоринов on 13.07.2018.
//

import Foundation
import PerfectHTTP



var arrOfGoods = Good.getArrayOfGoods()

class WorkWithGoodsController {
    
    let giveGood: (HTTPRequest, HTTPResponse) -> () = {request, response in
        do {
            let arr = request.params()
            guard arr[0].0 == "id" else{
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error dont see id"))
                return
            }
            for good in arrOfGoods{
                let idGood = Int(arr[0].1)
                if good.id == idGood ?? -1 {
                    try response.setBody(json: ["result": 1,
                                                "good": ["id": good.id,
                                                         "productName": good.productName,
                                                         "productPrice": good.productPrice]
                                        ])
                    response.completed()
                    return
                }
            }
            try response.setBody(json: ["result": 0])
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    let giveCatalogOfGoods: (HTTPRequest, HTTPResponse) -> () = {request, response in
        do {
            var jsonDic: [[String:AnyObject]] = []
            for good in arrOfGoods{
                var dic: [String:AnyObject] = [:]
                dic["id"] = good.id as AnyObject
                dic["productName"] = good.productName as AnyObject
                dic["productPrice"] = good.productPrice as AnyObject
                jsonDic.append(dic)
            }
            try response.setBody(json: jsonDic)
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    
    
}
