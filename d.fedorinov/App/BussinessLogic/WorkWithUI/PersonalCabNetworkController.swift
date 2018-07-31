import Foundation
import UIKit

protocol PersonalCabNetworkControllerDelegate {
    var delegatePersonalCabNetC: PersonalCabNetworkRequestsFactory { get set }
}

protocol PersonalCabNetworkRequestsFactory {
    func authorization(login: String,
                       password: String,
                       completionHandlerNavigation: @escaping (Bool) -> Void)
    func logout()
    func takeUserID(completionHandler: @escaping (Int) -> Void)
    func registration(user:User,
                      completionHandler: @escaping (Bool) -> Void)
    func checkAuthorization () -> (status:Bool, user:User?)
}

typealias PersonalCabNetworkUIViewControllerDelegate = UIViewController & PersonalCabNetworkControllerDelegate

///Выполняет логику работы с сетью по запросам к личному кобинету клиента для View контроллеров
class PersonalCabNetworkController: PersonalCabNetworkRequestsFactory {
    
    
    //MARK: - Constants
    
    private let controller: PersonalCabNetworkUIViewControllerDelegate
    //ЖЕНЬ ТЫ БЫ СДЕЛАЛ И СЮДА ФАБРИКУ? мне кажется уже нецелесообразно, они все итак хорошо закрыты
    private let supportingUIElementsFactory = SupportingUIElementsFactory()
    private let requestFactoryToPersonalAccount = RequestFactory.instance.makeRequestToPersonalAccount()
    private let userDefaults = PersonalCapDependenceFactory.instance.makeUserDefaults()
    private let alertFactory = PersonalCapDependenceFactory.instance.makeAlertFactory()
    
    
    //MARK: - Init
    
    init(controller: PersonalCabNetworkUIViewControllerDelegate) {
        self.controller = controller
        
    }
    

    //MARK: - Public methods
    
    
    //MARK: requests methods
    
    func authorization(login: String,
                       password: String,
                       completionHandlerNavigation: @escaping (Bool) -> Void) {
        
        startActivityIndcicator()
        
        requestFactoryToPersonalAccount.login(username: login,
                                              password: password)
        { [weak self] response in
            guard let persCabNetcontroller = self else {
                print("dont see controller")
                return
            }
            var isLogin:Bool = false
            do {
                switch response.result {
                case .success(let login):
                    if login.result == 1 {
                        try persCabNetcontroller.userDefaults.set(object:login.user,
                                                                  forKey: "ActiveUser")
                        isLogin = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }catch {
                print(error)
            }
            DispatchQueue.main.async {
                persCabNetcontroller.stopActivityIndcicator()
                completionHandlerNavigation(isLogin)
            }
            
        }
        
    }
    
    func takeUserID(completionHandler: @escaping (Int) -> Void) {
        requestFactoryToPersonalAccount.takeUserID() { response in
            switch response.result {
            case .success(let userID):
                let id = userID.result
                DispatchQueue.main.async {
                    completionHandler(id)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func registration(user:User,
                      completionHandler: @escaping (Bool) -> Void) {
        var isRegistred = false
        requestFactoryToPersonalAccount.registration(user: user) { response in
            switch response.result {
            case .success(let registration):
                print(registration)
                isRegistred = true
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completionHandler(isRegistred)
            }
        }
    }
    
    func logout() {
        guard let data = try? userDefaults.get(objectType: User.self,
                                               forKey: "ActiveUser"),
            let user = data
        else { return }
        requestFactoryToPersonalAccount.logOut(id: user.id) { [weak self] response in
            guard let pCNVControoler = self else { return }
            switch response.result {
            case .success(let logout):
                print(logout)
                pCNVControoler.userDefaults.removeObject(forKey: "ActiveUser")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func checkAuthorization () -> (status:Bool, user:User?) {
        if let data = try? userDefaults.get(objectType: User.self,
                                         forKey: "ActiveUser"),
           let user = data {
            
            return (status:true, user: user)
        }
        return (false, nil)
    }
    
    //MARK: - Private methods
    
    private func startActivityIndcicator() {
        let activityIndicator = supportingUIElementsFactory.makeActivityIndicator(controller: controller)
        controller.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func stopActivityIndcicator() {
        let tagAcivityIndicator = TagUIelement.activityIndicator
        if let activitiView = controller.view.viewWithTag(tagAcivityIndicator),
            let activityIndicator = activitiView as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activitiView.removeFromSuperview()
        }
    }
    
    
    
}
