import UIKit

class RegistrationViewController: UIViewController {

//MARK: - Constants
    let requestFactoryToPersonalAccount = RequestFactory().makeRequestToPersonalAccount()
    let alertFactory = AlertBornFactory()
    
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
            alertFactory.showRegisterError(controller: self)
            return
        }
        if let count = password.text?.count,
            count < 4 {
            alertFactory.showRegisterError(controller: self)
            return
        }
        
        let randomValue = Int(arc4random_uniform(UInt32(1000)))
        let semaphore = DispatchSemaphore(value: 0)
        var isRegister = false
        
        if  let email = email.text,
            let gender = gender.text,
            let creditCard = creditCard.text,
            let bio = bio.text {
            let user = User(id: randomValue,
                            username: login.text!,
                            password: password.text!,
                            email: email,
                            gender: gender,
                            creditCard: creditCard,
                            bio: bio)
            
            requestFactoryToPersonalAccount.registration(user: user) { response in
                switch response.result {
                case .success(let registration):
                    print(registration)
                    isRegister = true
                    semaphore.signal()
                case .failure(let error):
                    print(error.localizedDescription)
                    semaphore.signal()
                }
            }
        }
        
        semaphore.wait()
        if isRegister {
            alertFactory.showRegistrationSuccess(controller: self)
        }else {
            alertFactory.showRegisterError(controller: self)
        }
    }
    
//MARK: - Private methods
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
