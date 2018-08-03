import Foundation
import PerfectHTTP

var arrOfBaskets: [Basket] = []

class WorkWithBasketController {
    
    let addGoodToBasket: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard
            let str = request.postBodyString,
            let data = str.data(using: .utf8)
            else {
                response.completed(status: HTTPResponseStatus.custom(code: 400, message: "Wrong user data"))
                return
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            
            let idUser = json["idUser"] as! Int
            let idGood = json["idGood"] as! Int
            let quantity = json["quantity"] as! Int
            
            var bufferGood:Good? = nil
            for good in arrOfGoods{
                if good.id == idGood {
                     bufferGood = good
                    if good.quantity >= quantity {
                        bufferGood?.quantity = good.quantity - quantity
                        arrOfGoods = EdditingArray.chageElementsInArray(elementDeleting: good, elementAdding: bufferGood!, arrOfElement: arrOfGoods)
                    }else{
                        try response.setBody(json: ["result": 0, "userMessage": "количество товара больше чем имеется"])
                        response.completed()
                        return
                    }
                }
            }
            guard var goodGoToBasket = bufferGood else {
                try response.setBody(json: ["result": 0, "userMessage": "такого товара не существует"])
                response.completed()
                return
            }
            goodGoToBasket.quantity = quantity
            
            
            var basketBuffer:Basket? = nil
            for basket in arrOfBaskets {
                if basket.idUser == idUser {
                    var arrOfGoods =  basket.arrOfGoods
                    var isGood = false
                    for good in basket.arrOfGoods {
                        if good.id == idGood {
                            var goodBuffer = good
                            goodBuffer.quantity = goodBuffer.quantity + goodGoToBasket.quantity
                            arrOfGoods = EdditingArray.chageElementsInArray(elementDeleting: good, elementAdding: goodBuffer, arrOfElement: arrOfGoods)
                            isGood = true
                        }
                    }
                    if isGood {
                        basketBuffer = basket
                        basketBuffer?.arrOfGoods = arrOfGoods
                        arrOfBaskets = EdditingArray.chageElementsInArray(elementDeleting: basket, elementAdding: basketBuffer!, arrOfElement: arrOfBaskets)
                        
//                        for good in arrOfGoods{
//                            if good.id == idGood {
//                                print("количество товара \(good.id) после добавления равно = \(good.quantity)")
//                            }
//                        }
//                        for basket in arrOfBaskets {
//                            for good in basket.arrOfGoods {
//                                print("basket id =\(basket.idUser) arr of goods =\(good.id) quantity \(good.quantity)")
//                            }
//                        }
                        
                        try response.setBody(json: ["result": 1, "userMessage": "Товар добавлен в корзину"])
                        response.completed()
                        return
                    }
                    
                }
            }
            
            var hasIdUser = false
            for basket in arrOfBaskets {
                if basket.idUser == idUser {
                    basket.append(good: goodGoToBasket)
                    hasIdUser = true
                }
            }
            if hasIdUser == false {
                let arrOfGood = [goodGoToBasket]
                let basket = Basket(idUser: idUser, arrOfGoods: arrOfGood)
                arrOfBaskets.append(basket)
            }
           
//            for good in arrOfGoods{
//                if good.id == idGood {
//                    print("количество товара \(good.id) после добавления равно = \(good.quantity)")
//                }
//            }
            
            try response.setBody(json: ["result": 1, "userMessage": "Товар добавлен в корзину"])
            response.completed()
            
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let giveBasket: (HTTPRequest, HTTPResponse) -> () = { request, response in
        do {
            guard let idUserString = request.param(name: "idUser"),
                let idUser = Int(idUserString)
                else {
                    response.completed(
                        status: HTTPResponseStatus.custom(code: 400, message: "Parse data error dont see userID"))
                    return
            }
            
            for basket in arrOfBaskets {
                if basket.idUser == idUser {
                    
                    var jsonDic: [[String:AnyObject]] = []
                    
                    for good in basket.arrOfGoods {
                        var dic: [String:AnyObject] = [:]
                        dic["id"] = good.id as AnyObject
                        dic["productName"] = good.productName as AnyObject
                        dic["productPrice"] = good.productPrice as AnyObject
                        dic["quantity"] = good.quantity as AnyObject
                        jsonDic.append(dic)
                    }
                    
//                    print(jsonDic)
                    try response.setBody(json: jsonDic)
                    response.completed()
                }
            }
            response.completed(status: HTTPResponseStatus.custom(code: 404, message: "Dont find such good"))
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let deleteGoodFromBasket: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard
            let str = request.postBodyString,
            let data = str.data(using: .utf8)
            else {
                response.completed(status: HTTPResponseStatus.custom(code: 400, message: "Wrong user data"))
                return
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            let idUser = json["idUser"] as! Int
            let idGood = json["idGood"] as! Int
            let quantity = json["quantity"] as! Int
            
            var bufferGood:Good? = nil
            var changingGoodInFactory: Good? = nil
            for good in arrOfGoods{
                if good.id == idGood {
                    print(json)
                    bufferGood = good
                    changingGoodInFactory = good
                    bufferGood?.quantity = good.quantity + quantity
                }
            }
            
            guard var goodDeleteFromBasket = bufferGood else {
                try response.setBody(json: ["result": 0, "userMessage": "такого товара не существует"])
                response.completed()
                return
            }
            
            goodDeleteFromBasket.quantity = quantity
            
            var hasIdUser = false
            for basket in arrOfBaskets {
                if basket.idUser == idUser {
                    basket.delete(good: goodDeleteFromBasket)
                    arrOfGoods = EdditingArray.chageElementsInArray(elementDeleting: changingGoodInFactory!, elementAdding: bufferGood!, arrOfElement: arrOfGoods)
                    hasIdUser = true
                }
            }
            if hasIdUser == false {
                try response.setBody(json: ["result": 0, "userMessage": "Отсутствует пользователь с такой корзиной"])
                response.completed()
                return
            }
            for good in arrOfGoods{
                if good.id == idGood {
                    print("количество товара   \(good.id) после удаления равно = \(good.quantity)")
                }
            }
            try response.setBody(json: ["result": 1, "userMessage": "Товар удален из корзины"])
            response.completed()
            
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let payedBasket: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard
            let str = request.postBodyString,
            let data = str.data(using: .utf8)
            else {
                response.completed(status: HTTPResponseStatus.custom(code: 400, message: "Wrong user data"))
                return
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            let idUser = json["idUser"] as! Int
            
            var hasIdUser = false
            for basket in arrOfBaskets{
                if basket.idUser == idUser {
                    arrOfBaskets = EdditingArray.deleteElementFromArray(element: basket, arrOfElement: arrOfBaskets)
                    hasIdUser = true
                }
            }
            if hasIdUser == false {
                try response.setBody(json: ["result": 0, "userMessage": "отсутствует корзина"])
                response.completed()
            }
            
            for good in arrOfGoods{
                print("количество товара   \(good.id) после оплаты равно = \(good.quantity)")
            }
            
            
            try response.setBody(json: ["result": 1, "userMessage": "Заказ оплачен"])
            response.completed()
            
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
}
