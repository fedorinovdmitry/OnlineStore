import UIKit

class LastBasketCell: BasketNetworkControllerDelegateToCell {

    
    //MARK: - Constants
    
    let alertFactory = PersonalCapDependenceFactory.instance.makeAlertFactory()
    lazy var delegateBasketNetworkController: BasketNetworkinCell? = NetworkDelegateControllersBornFactory().makeBasketNetworkControllerDelegate(viewController: self)
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var totalPrice: UILabel!
    
    
    //MARK: - Public Properties
    
    var controller:UITableViewController? = nil
    
    
    //MARK: - IBAction
    
    @IBAction func payOrder(_ sender: Any) {
        
        guard let delegate = delegateBasketNetworkController,
              let controller = controller
            else { return }
        delegate.payOrder() { [weak self] in
            guard let cell = self
            else { return }
            cell.alertFactory.alertWithPop(controller: controller,
                                           title: "Payed",
                                           message: "Order payed")
            
            
        }
        
    }

}
