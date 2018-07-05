//
//  AppDelegate.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 03.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let requestFactory = RequestFactory()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let registration = requestFactory.makeRegistrationRequestFactory()
        print("регистрируемся")
        registration.registration(id_user: 123,
                                  userName: "Somebody",
                                  password: "mypassword",
                                  email: "some@some.ru",
                                  gender: "m",
                                  credit_card: "9872389-2424-234224-234",
                                  bio: "This is good! I think I will switch to another language") { response in
                                    switch response.result {
                                    case .success(let registration):
                                        print(registration)
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                    
                                    // поидее мы же вполне можем при изменении данных изменить только что-то одно, но тут нужно бы знать как обрабатывает сервер а сервер у нас тупой))по-хорошему надо идти в подвал к бекендшикам и разбираться, как понормальному реализовывать изменения данных. Но если в подвал идти далеко и лень, а связи у них там нету, я бы пытался хотя бы при отправке данных записывать данные текущего пользователя и при измемнение отправлять все старые данные,а в изменненом поле соответсвенно новое значение и пошел бы чего-нибудь покушал, чем спуускаться к ним в холодный подвал))
                                    let changeUserData = self.requestFactory.makeChangeUserDataRequestFactory()
                                    print("изменение данных")
                                    changeUserData.changeUserData(id_user: 123,
                                                                  userName: "Somebody",
                                                                  password: "mypassword",
                                                                  email: "some@some.ru",
                                                                  gender: "m",
                                                                  credit_card: "9872389-2424-234224-234",
                                                                  bio: "This is good! I think I will switch to another language"){ response in
                                                                    switch response.result {
                                                                    case .success(let changeUserData):
                                                                        print(changeUserData)
                                                                    case .failure(let error):
                                                                        print(error.localizedDescription)
                                                                    }
                                                                    let auth = self.requestFactory.makeAuthRequestFactory()
                                                                    print("авторизовываемся")
                                                                    auth.login(userName: "Somebody", password: "mypassword") { response in
                                                                        switch response.result {
                                                                        case .success(let login):
                                                                            print(login)
                                                                        case .failure(let error):
                                                                            print(error.localizedDescription)
                                                                        }
                                                                        let deauth = self.requestFactory.makeDeauthRequestFactory()
                                                                        print("деавторизовываемся")
                                                                        deauth.logOut(id_user: 123) { response in
                                                                            switch response.result {
                                                                            case .success(let logout):
                                                                                print(logout)
                                                                            case .failure(let error):
                                                                                print(error.localizedDescription)
                                                                            }
                                                                        }
                                                                    }
                                    }
                                    
                                    
                                    
        }
        
        
        
        
        
        
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

