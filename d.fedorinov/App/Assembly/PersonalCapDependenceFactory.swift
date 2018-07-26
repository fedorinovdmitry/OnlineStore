import UIKit
import Foundation

class PersonalCapDependenceFactory {
    static let instance = PersonalCapDependenceFactory()
    private init(){}
    
    func makeAlertFactory() -> AlertFactory {
        return AlertBornFactory()
    }
    func makeNetworkControllersFactory() -> NetworkDelegateControllersFactory {
        return NetworkDelegateControllersBornFactory()
    }
    func makeUserDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
}
