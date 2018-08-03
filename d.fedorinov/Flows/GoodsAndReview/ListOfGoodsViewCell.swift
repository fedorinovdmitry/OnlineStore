import UIKit

class ListOfGoodsViewCell: BasketNetworkControllerDelegateToCell {
    

    //MARK: - Constants
    
    let alertFactory = PersonalCapDependenceFactory.instance.makeAlertFactory()
    lazy var delegateBasketNetworkController: BasketNetworkinCell? = NetworkDelegateControllersBornFactory().makeBasketNetworkControllerDelegate(viewController: self)
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameOfGood: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    //MARK: - Public Properties
    
    var goodId: Int? = nil
    var controller:UITableViewController? = nil
    
    
    //MARK: - IBAction
    
    @IBAction func addToBasket(_ sender: Any) {
        
        
        
        guard let delegate = delegateBasketNetworkController,
              let id = goodId,
              let controller = controller
        else { return }
        delegate.addToBasket(idGood: id) {
            self.alertFactory.showAlert(controller: controller, title: "Added", message: "Good added to basket")
            controller.tableView.reloadData()
        }
        
    }
    
 
}
