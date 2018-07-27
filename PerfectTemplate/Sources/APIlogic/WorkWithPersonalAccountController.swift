import Foundation
import PerfectHTTP

var users: [User] = [] //зарегестрированные пользователи
var authUsersId: [Int] = [] //id авторизованые пользователи


class WorkWithPersonalAccountController {
    
    let register: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard
            let str = request.postBodyString,
            let data = str.data(using: .utf8)
            else{
                response.completed(status: HTTPResponseStatus.custom(code: 400, message: "Wrong user data"))
                return
        }
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            guard let registerRequest = User(json) else{
                try response.setBody(json: ["result": 0, "userMessage": "Отправлены неверные/не все данные!"])
                response.completed()
                return
            }
            users.append(registerRequest)
            print("registrationRequest - \(registerRequest)")
            try response.setBody(json: ["result": 1, "userMessage": "Регистрация прошла успешно!"])
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let login: (HTTPRequest, HTTPResponse) -> () = { request, response in
        
        guard
            
            let str = request.postBodyString,
            let data = str.data(using: .utf8)
            else{
                response.completed(status: HTTPResponseStatus.custom(code: 400, message: "Wrong user data"))
                return
        }
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            
            guard
                let username = json["username"] as? String,
                let password = json["password"] as? String
                else{
                    response.completed(
                        status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - wrong input value"))
                    return
            }
            
            for user in users {
                if user.username == username && user.password == password {
                    for userId in authUsersId {
                        if userId == user.id {
                            authUsersId = EdditingArray.deleteElementFromArray(element: userId, arrOfElement: authUsersId)
                        }
                    }
                    try response.setBody(json: ["result": 1,
                                                "user": ["id": user.id,
                                                         "username": user.username,
                                                         "password": user.password,
                                                         "email": user.email,
                                                         "gender": user.gender,
                                                         "creditCard": user.creditCard,
                                                         "bio": user.bio],
                                                "authToken":"token\(user.id)"])
                    authUsersId.append(user.id)
                    print(authUsersId)
                    response.completed()
                    return
                }
            }
            
            response.completed(status: HTTPResponseStatus.custom(code: 404, message: "dont have such user"))

           
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let logout: (HTTPRequest, HTTPResponse) -> () = {request, response in
        
        do {
            let arr = request.params()
            guard arr[0].0 == "id" else{
                response.completed(
                    status: HTTPResponseStatus.custom(code: 400, message: "Parse data error dont see id"))
                return
            }
            for id in authUsersId{
                let idlogout = Int(arr[0].1)
                if id == idlogout ?? -1 {
                    authUsersId = EdditingArray.deleteElementFromArray(element: id, arrOfElement: authUsersId)
                    print("деавторизован - \(authUsersId)")
                    try response.setBody(json: ["result": 1, "userMessage": "Деавторизован"])
                    response.completed()
                }
            }
            try response.setBody(json: ["result": 0, "userMessage": "сессия пользователя не найдена"])
            response.completed()

        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let changeUserData: (HTTPRequest, HTTPResponse) -> () = {request, response in
        guard
            let str = request.postBodyString,
            let data = str.data(using: .utf8)
            else{
                response.completed(status: HTTPResponseStatus.custom(code: 400, message: "Wrong user data"))
                return
        }
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            guard let chageRequest = User(json) else{
                try response.setBody(json: ["result": 0, "userMessage": "Отправлены неверные/не все данные!"])
                response.completed()
                return
            }
            print("changeRequest - \(chageRequest)")
            
            for user in users {
                if chageRequest.id == user.id {
                    users = EdditingArray.chageElementsInArray(elementDeleting: user,
                                                               elementAdding: chageRequest,
                                                               arrOfElement: users)
                    try response.setBody(json: ["result": 1, "userMessage": "данные измененны"])
                    response.completed()
                }
            }
            
            try response.setBody(json: ["result": 0, "userMessage": "пользователь не найден"])
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    let giveUserID: (HTTPRequest, HTTPResponse) -> () = {request, response in
        do {
            var id = 0
            if users.isEmpty {
                id = 1
            }else {
                var max = 0
                for user in users {
                    if user.id > max {
                        max = user.id
                    }
                }
                id = max + 1
            }
            
            var json:[String:AnyObject] = [:]
            json["result"] = id as AnyObject
            json["userMessage"] = "this is free user id" as AnyObject
            print(json)
            try response.setBody(json: json)
            response.completed()
            
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
}


