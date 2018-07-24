import UIKit

///Фабрика пораждающая алерты
class AlertBornFactory {
    ///Алерт успешной регистрации
    func showRegistrationSuccess(controller: UIViewController) {
        let alter = UIAlertController(title: "Success",
                                      message: "you was registred",
                                      preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK",
                                        style: .default) { (UIAlertAction) in
            controller.performSegue(withIdentifier: "unwindRegistration",
                                    sender: self)
        }
        alter.addAction(action)
        controller.present(alter,
                           animated: true,
                           completion: nil)
    }
    ///Алерт ошибки регистрации
    func showRegisterError(controller: UIViewController) {
        let alter = UIAlertController(title: "Error",
                                      message: "Error input data", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)
        
        alter.addAction(action)
        controller.present(alter,
                animated: true,
                completion: nil)
    }
    ///Алерт ошибки авторизации
    func showLoginError(controller: UIViewController) {
        let alter = UIAlertController(title: "Error",
                                      message: "Error input data",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)
        alter.addAction(action)
        controller.present(alter,
                animated: true,
                completion: nil)
    }
}
