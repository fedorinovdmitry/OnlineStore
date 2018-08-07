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
    
    var good: Good? = nil
    var controller:UITableViewController? = nil
    
    
    //MARK: - IBAction
    
    @IBAction func addToBasket(_ sender: Any) {
        
        guard let delegate = delegateBasketNetworkController,
              let good = good,
              let controller = controller
        else { return }
        delegate.addToBasket(idGood: good.id) { [weak self] in
            guard let cell = self else { return }
            
            cell.track(AnalyticsEvent.addToCart(good: good))
            
            cell.alertFactory.showAlert(controller: controller, title: "Added", message: "Good added to basket")
            controller.tableView.reloadData()
        }
        
    }
    
 
}

//добавялем методы аналитики
extension ListOfGoodsViewCell: TrackableMixin {}
