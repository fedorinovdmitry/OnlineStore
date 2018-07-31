import UIKit

///Контроллер карточки товара
class GoodCartViewController: ReviewsNetworkUIViewControllerDelegate {
    
    
    //MARK: - Constants
    
    let userDefaults = PersonalCapDependenceFactory.instance.makeUserDefaults()
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var goodPrice: UILabel!
    @IBOutlet weak var goodQuantity: UILabel!
    
    @IBOutlet weak var goodImage: UIImageView!
    
    @IBOutlet weak var addReview: UITextView!
    
    @IBOutlet weak var contentContainer: UIView!
    
    @IBOutlet weak var listOfReview: UITableView!
    
    @IBOutlet weak var sendbutton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: - Public Properties
    
    var good: Good? = nil
    
    lazy var delegateReviewNetworkController: ReviewsNetworkControllerRequestsFactory =
        NetworkDelegateControllersBornFactory().makeReviewsNetworkControllerDelegate(controller: self)
    
    
    //MARK: - Private Properties
    
    private var tableManager: ReviewTableController?
    private var reviews: [Review] = []
    
    
    //MARK: - LifeStyle ViewController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nottificationCenterConfig()
        labelConfig()
        takeReviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapRecongnizerConfig()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nottificationCenterClean()
    }
    
    
    //MARK: - IBAction
    
    @IBAction func sendReview(_ sender: Any) {
        sendbutton.isEnabled = false
        sendReviewToNetwork()
    }
    
    
    //MARK: - Private methods
    
    
    //MARK: Reviews methods
    
    private func sendReviewToNetwork() {
        if let review = getReview() {
            
            delegateReviewNetworkController.sendReview(review: review) { [weak self] arr in
                guard let goodCartVC = self
                    else {
                        return
                }
                goodCartVC.takeReviews()
                goodCartVC.sendbutton.isEnabled = true
            }
        }
    }
    
    private func takeReviews() {
        if let good = good {
            delegateReviewNetworkController.takeReviews(idGood: good.id) { [weak self] arr in
                guard let goodCartVC = self
                else {
                    return
                }
                goodCartVC.reviews = arr
                goodCartVC.tableManager = ReviewTableController(tableView: goodCartVC.listOfReview, reviews: arr)
                goodCartVC.listOfReview.reloadData()
            }
        }
        
    }
    
    private func getReview() -> Review? {
        if let data = try? userDefaults.get(objectType: User.self,
                                            forKey: "ActiveUser"),
            let user = data,
            let textOfReview = addReview.text,
            textOfReview.count > 0,
            let good = good {
            
            return Review(idGood: good.id, idUser: user.id, textOFReview: textOfReview)
        }
        return nil
    }
    
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
    
    
    //MARK: Config methods
    
    private func labelConfig() {
        listOfReview.rowHeight = 70.0
        if let good = good {
            goodName.text = good.productName
            goodPrice.text = String(good.productPrice)
            goodQuantity.text = String(good.quantity!)
        }
    }
    
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
    
    private func tableManagerConfig() {
        tableManager = ReviewTableController(tableView: listOfReview, reviews: reviews)
    }
    //MARK: - Navigation
    

}

