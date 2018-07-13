//
//  WorkWithPersonalAccountController.swift
//  COpenSSL
//
//  Created by Дмитрий Федоринов on 12.07.2018.
//

import Foundation
import PerfectHTTP

//пока пусть в глобальной, потом придумаю где хранить
var users: [User] = []//зарегестрированные пользователи
var authUsersId: [Int] = []//авторизованые
class WorkWithPersonalAccountController {
    let register: (HTTPRequest, HTTPResponse) -> () = {request, response in
        guard
            let str = request.postBodyString,
            let data = str.data(using: .utf8)
            else{
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong user data"))
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
    
    let login: (HTTPRequest, HTTPResponse) -> () = {request, response in
        
        guard
            
            let str = request.postBodyString,
            let data = str.data(using: .utf8)
            else{
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong user data"))
                return
        }
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            
            guard
                let username = json["username"] as? String,
                let password = json["password"] as? String
                else{
                    response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - wrong input value"))
                    return
            }
            for user in users {
                if user.username == username && user.password == password {
                    
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
            
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "dont have such user"))

           
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let logout: (HTTPRequest, HTTPResponse) -> () = {request, response in
        
        do {
            let arr = request.params()
            guard arr[0].0 == "id" else{
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error dont see id"))
                return
            }
            for id in authUsersId{
                let idlogout = Int(arr[0].1)
                if id == idlogout ?? -1 {
                    if let index = authUsersId.index(of: id){
                        
                        authUsersId.remove(at: index)
                        print(authUsersId)
                        try response.setBody(json: ["result": 1])
                        response.completed()
                    }
                }
            }
            try response.setBody(json: ["result": 0])
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
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong user data"))
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
                    if let index = users.index(of: user){
                        users.remove(at: index)
                        users.insert(chageRequest, at: index)
                        print(users)
                        try response.setBody(json: ["result": 1, "userMessage": "данные измененны"])
                        response.completed()
                    }
                }
            }
            
            try response.setBody(json: ["result": 0, "userMessage": "пользователь не найден"])
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
}


