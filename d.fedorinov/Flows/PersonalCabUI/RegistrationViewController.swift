import UIKit

class RegistrationViewController: PersonalCabNetworkUIViewControllerDelegate {

    
    //MARK: - Constants
    
    let requestFactoryToPersonalAccount = RequestFactory.instance.makeRequestToPersonalAccount()
    let alertFactory = PersonalCapDependenceFactory.instance.makeAlertFactory()
    lazy var delegatePersonalCabNetC: PersonalCabNetworkRequestsFactory = PersonalCapDependenceFactory.instance.makeNetworkControllersFactory().makePersonalCabNetworkControllerDelegate(controller: self)
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var creditCard: UITextField!
    @IBOutlet weak var bio: UITextField!
    
    
    //MARK: - LifeStyle ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(self.hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillShow,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillHide,
                                                  object: nil)
    }
    
    
    //MARK: - IBAction
    
    ///Метод регистрации
    @IBAction func endRegistration(_ sender: Any) {
        if let count = login.text?.count,
               count < 4 {
            alertFactory.showAlert(controller: self,
                                   title: "Registration error",
                                   message: "input value of login textfield is < 5")
            return
        }
        if let count = password.text?.count,
               count < 4 {
            alertFactory.showAlert(controller: self,
                                   title: "Registration error",
                                   message: "input value of password textfield is < 5")
            return
        }
        guard let login = login.text,
            let password = password.text,
            let email = email.text,
            let gender = gender.text,
            let creditCard = creditCard.text,
            let bio = bio.text
            else {
                return
        }
        delegatePersonalCabNetC.takeUserID(){ [weak self] userId in
            guard let registrationController = self
            else { return }
            let user = User(id: userId,
                            username: login,
                            password: password,
                            email: email,
                            gender: gender,
                            creditCard: creditCard,
                            bio: bio)
            
            registrationController.delegatePersonalCabNetC.registration(user: user) {
                [weak registrationController] isRegistred in
                
                guard let controller = registrationController
                else { return }
                
                if isRegistred {
                    controller.track(AnalyticsEvent.signUp(controller: controller,
                                                           success: true,
                                                           username: user.username,
                                                           id: user.id))
                    
                    controller.alertFactory.showAlert(controller: controller,
                                                      title: "Registred",
                                                      message: "Registred success")
                    controller.performSegue(withIdentifier: "unwindRegistration",
                                            sender: self)
                }else {
                    controller.track(AnalyticsEvent.signUp(controller: controller,
                                                           success: false,
                                                           username: user.username,
                                                           id: user.id))
                    controller.alertFactory.showAlert(controller: controller,
                                                      title: "Registration error",
                                                      message: "")
                }
            }
        }
        
    }
    /// Путь на контроллер авторизации
    @IBAction func backToLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindRegistration",
                                sender: self)
    }
    
    
    //MARK: - Private methods
    
    
    //MARK: Keyboard methods
    
    @objc private func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0,
                                             0.0,
                                             kbSize.height,
                                             0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    ///когда клавиатура исчезает
    @objc private func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
}

//добавялем методы аналитики
extension RegistrationViewController: TrackableMixin {}
