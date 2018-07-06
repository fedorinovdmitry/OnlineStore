//
//  TestNetwork.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 06.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation


extension AppDelegate{
    func registration(){
        print("регистрируемся")
        requestFactory.registration(user: user){ response in
            switch response.result {
            case .success(let registration):
                print(registration)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.changeUserData()
        }
    }
    func changeUserData(){
        
        print("изменение данных")
        requestFactory.changeUserData(user: user){ response in
            switch response.result {
            case .success(let changeUserData):
                print(changeUserData)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.authorithation()
        }
    }
    func authorithation(){
        
        print("авторизовываемся")
        requestFactory.login(userName: user.userName, password: user.password){response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.deautharization()
        }
    }
    func deautharization(){
        
        print("деавторизовываемся")
        requestFactory.logOut(id: user.id){ response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}
