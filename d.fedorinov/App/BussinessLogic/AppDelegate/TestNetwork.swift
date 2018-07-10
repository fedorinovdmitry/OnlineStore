//
//  TestNetwork.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 06.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation

// тест работы запросов с личным кабинетом
extension AppDelegate{
    func registration(){
        print("регистрируемся")
        requestFactoryToPersonalAccount.registration(user: user){ response in
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
        requestFactoryToPersonalAccount.changeUserData(user: user){ response in
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
        requestFactoryToPersonalAccount.login(userName: user.userName, password: user.password){response in
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
        requestFactoryToPersonalAccount.logOut(id: user.id){ response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.takeCatalogOfGoods()
        }
        
    }
}
// тест работы запросов с товарами
extension AppDelegate{
    func takeCatalogOfGoods(){
        print("получаем каталог товаров")
        requestFactoryToWorkWithGoods.takeCatalogDataOfGoods(pageNumber: 1, idCategory: 1){ response in
            switch response.result {
            case .success(let catalog):
                print(catalog)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.takeGood()
        }
        
    }
    func takeGood(){
        print("получаем товар")
        requestFactoryToWorkWithGoods.takeGood(id: 123){ response in
            switch response.result {
            case .success(let good):
                print(good)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
