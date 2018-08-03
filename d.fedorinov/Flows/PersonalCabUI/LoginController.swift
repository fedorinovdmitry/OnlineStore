import UIKit
import OHHTTPStubs

private enum AuthStatus {
    case isAuth
    case isNotAuth
}
///контроллер экрана авторизации
class LoginController: PersonalCabNetworkUIViewControllerDelegate {
    
    //MARK: - Constants
    
    let requestFactoryToPersonalAccount = RequestFactory.instance.makeRequestToPersonalAccount()
    let userDefaults = PersonalCapDependenceFactory.instance.makeUserDefaults()
    let alertFactory = PersonalCapDependenceFactory.instance.makeAlertFactory()
    lazy var delegatePersonalCabNetC: PersonalCabNetworkRequestsFactory = PersonalCapDependenceFactory.instance.makeNetworkControllersFactory().makePersonalCabNetworkControllerDelegate(controller: self)
    
    //MARK: - Outlets
    
    @IBOutlet weak var contentViewContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    
    //MARK: - Private properties
    private var isAuththorization:AuthStatus = .isNotAuth
    private lazy var user: User? = nil
    //MARK: - LifeStyle ViewController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nottificationCenterConfig()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapRecongnizerConfig()
        checkAuth()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nottificationCenterClean()
    }
    
    
    //MARK: - IBAction
    
    @IBAction func authorization(_ sender: Any) {
        
        var login: String = ""
        var password: String = ""
        
        if isAuththorization == .isAuth {
            guard let authUser = user
            else {
                return
            }
            login = authUser.username
            password = authUser.password
        }else {
            guard let loginInput = loginInput.text,
                  let passwordInput = passwordInput.text,
                  loginInput.count > 4,
                  passwordInput.count > 4
            else {
                    alertFactory.showAlert(controller: self,
                                           title: "Authorization Error",
                                           message: "count of simbol is < 5")
                    return
            }
            login = loginInput
            password = passwordInput
        }
        
        delegatePersonalCabNetC.authorization(login: login,
                                              password: password){ [weak self] isLogin in
            guard let loginController = self
            else { return }
            if isLogin {
                loginController.performSegue(withIdentifier: "loginSuccess",
                                   sender: self)
            }else {
                loginController.alertFactory.showAlert(controller: self!,
                                                       title: "Authorization Error",
                                                       message: "You need to register")
            }
        }
        
    }
    
    @IBAction func registration(_ sender: Any) {
        isAuththorization = .isNotAuth
        self.performSegue(withIdentifier: "registration",
                          sender: self)
    }
    
    
    //MARK: - Navigation
    
    @IBAction func logOut(unwindSegue: UIStoryboardSegue) {
        delegatePersonalCabNetC.logout()
    }
    
    @IBAction func registrationEnd(unwindSegue: UIStoryboardSegue) {}
    
    
    //MARK: - Private methods
    
    //TODO: delete it -> ЖЕНЬ КАК ЖЕ ХОЧЕТСЯ ПРОДЕЛЕГИРОВАТЬ ВСЕ ЭТИ МЕТОДЫ С КЛАВОЙ или хотя бы в общий экстеншен, НО Я НЕМОГУ НИЧЕГО ПРИДУМАТЬ ИЗ-ЗА ОБЖЕКТИВНЫХ МЕТОДОВ ИХ НЕЛЬЗЯ В ПРОТОКОЛ ЗАПИХАТЬ И ОТ ЭТОГО ГРУСТНО
    
    
    //MARK: Keyboard methods
    
    ///когда клавиатура появляется
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = self.contentViewContainer.frame.size
    }
    
    
    //MARK: Config methods
    
    private func nottificationCenterConfig() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    private func nottificationCenterClean() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillShow,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillHide,
                                                  object: nil)
    }
    
    private func tapRecongnizerConfig() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(self.hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    private func checkAuth() {
        let isAuth = delegatePersonalCabNetC.checkAuthorization()
        if (isAuth.status) {
            isAuththorization = .isAuth
            user = isAuth.user
            authorization(self)
        }
    }
}

