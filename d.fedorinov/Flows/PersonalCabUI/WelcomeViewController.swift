import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var name: UILabel!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let data = try? userDefaults.get(objectType: User.self,
                                               forKey: "ActiveUser"),
              let user = data
        else {
                return
        }
        name.text = user.username
    }
}
