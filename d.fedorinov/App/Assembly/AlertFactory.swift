import UIKit

///Фабрика пораждающая алерты
protocol AlertFactory {
    func showAlert(controller: UIViewController,
                   title:String,
                   message:String)
    func alertWithPop(controller: UIViewController,
                      title:String,
                      message:String)
}
//TODO: переделать 
class AlertBornFactory: AlertFactory {

    ///Алерт стандартной ошибки регистрации
    func showAlert(controller: UIViewController,
                   title:String,
                   message:String) {
        let alter = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)
        
        alter.addAction(action)
        controller.present(alter,
                           animated: true,
                           completion: nil)
        
    }
    
    func alertWithPop(controller: UIViewController,
                      title:String,
                      message:String) {
        let alter = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (self) in
            controller.navigationController?.popViewController(animated: true)
        }
        
        alter.addAction(action)
        controller.present(alter,
                           animated: true,
                           completion: nil)
        
    }
}
