import UIKit

class BasketTableViewController: BasketNetworkControllerDelegateToTabbleController {


    //MARK: - Constants
    
    lazy var delegateBasketNetworkController: BasketNetworkInTable? = NetworkDelegateControllersBornFactory().makeBasketNetworkControllerDelegate(viewController: self)
    let alertFactory = PersonalCapDependenceFactory.instance.makeAlertFactory()
    
    
    //MARK: - Private Properties
    
    var arrOfGoods:[Good] = []
    
    
    //MARK: - LifeStyle ViewController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        takeBasket()
        tableView.reloadData()
    }
    
    
    //MARK: - Public methods
    
    
    // MARK: Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrOfGoods.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrOfGoods.count == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "lastCellInBasket") as! LastBasketCell
            cell.totalPrice.text = totalSum()
            cell.controller = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as! GoodInBasketCell
            let good = arrOfGoods[indexPath.row]
            cell.goodName.text = good.productName
            cell.goodPrice.text = String(good.productPrice)
            
            let quantity = good.quantity!
            cell.quantity.text = String(quantity)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let good = arrOfGoods[indexPath.row]
            let quantity = good.quantity ?? 1
            deleteGoodFromBasket(idGood: good.id, quantity: quantity)
            arrOfGoods = EdditingArray.deleteElementFromArray(element: good, arrOfElement: arrOfGoods)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    
    //MARK: - Private methods
    
    private func takeBasket() {
        guard let delegate = delegateBasketNetworkController
        else { return }
        delegate.takeBasket() { [weak self] arr in
            guard let basketController = self
                else { return }
            basketController.arrOfGoods = arr
            basketController.tableView.reloadData()
        }
    }
    
    private func deleteGoodFromBasket(idGood: Int, quantity: Int) {
        guard let delegate = delegateBasketNetworkController
            else { return }
        delegate.deleteGoodFromBasket(idGood: idGood, quantity: quantity)
    }
    
    private func totalSum() -> String {
        var sum = 0
        for good in arrOfGoods {
            let quantity = good.quantity ?? 1
            sum = sum + (good.productPrice * quantity)
        }
        return String(sum)
    }
    

}
