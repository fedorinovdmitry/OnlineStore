import UIKit

class WelcomeViewController: UIViewController {


    //MARK: - Constants
    
    let userDefaults = PersonalCapDependenceFactory.instance.makeUserDefaults()
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var name: UILabel!

    
    //MARK: - LifeStyle ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setName()
        
    }
    
    
    //MARK: - IBAction
    
    @IBAction func listOfGoods(_ sender: Any) {
        self.performSegue(withIdentifier: "listOfGoods",
                          sender: self)
    }
    
    @IBAction func goToBasket(_ sender: Any) {
        self.performSegue(withIdentifier: "basket",
                          sender: self)
    }
    
    
    //MARK: - Private methods
    
    private func setName() {
        guard let data = try? userDefaults.get(objectType: User.self,
                                               forKey: "ActiveUser"),
            let user = data
            else {
                return
        }
        name.text = user.username
    }
}
