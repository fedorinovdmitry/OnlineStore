import UIKit
import OHHTTPStubs


class LoginController: UIViewController {
    
//MARK: - Constants
    let requestFactoryToPersonalAccount = RequestFactory().makeRequestToPersonalAccount()
    let userDefaults = UserDefaults.standard
    let alertFactory = AlertBornFactory()
    
//MARK: - Outlets
    @IBOutlet weak var contentViewContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
//MARK: - LifeStyle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
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
    
//MARK: - Navigation
    @IBAction func logOut(unwindSegue: UIStoryboardSegue) {
        
        guard let data = try? userDefaults.get(objectType: User.self,
                                               forKey: "ActiveUser"),
              let user = data
            else {
                return
        }
        requestFactoryToPersonalAccount.logOut(id: user.id) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func registrationEnd (unwindSegue: UIStoryboardSegue) {}
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "loginSuccess" {
            let checkResult = authorithation()
            if !checkResult {
                alertFactory.showLoginError(controller: self)
            }
            return checkResult
        }
        if identifier == "registration" {
            return true
        }
        return false
    }
    
//MARK: - Public methods
    
    
//MARK: - Private methods
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
    
    private func authorithation() -> Bool {
        let login = loginInput.text!
        let password = passwordInput.text!
        
        let semaphore = DispatchSemaphore(value: 0)
        let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        var isLogin = false
        requestFactoryToPersonalAccount.login(username: login,
                                              password: password) { response in
            switch response.result {
            case .success(let login):
                if login.result == 1 {
                    isLogin = true
                    try? self.userDefaults.set(object:login.user,
                                               forKey: "ActiveUser")
                }
                semaphore.signal()
            case .failure(let error):
                print(error.localizedDescription)
                semaphore.signal()
            }
        }
        semaphore.wait()
        activityIndicator.stopAnimating()
        return isLogin
    }

}

