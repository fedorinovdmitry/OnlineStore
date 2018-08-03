import UIKit

class BasketTableViewController: BasketNetworkControllerDelegateToTabbleController {

    
    //MARK: - Custom types
    //MARK: - Constants
    
    lazy var delegateBasketNetworkController: BasketNetworkInTable? = NetworkDelegateControllersBornFactory().makeBasketNetworkControllerDelegate(viewController: self)
    let alertFactory = PersonalCapDependenceFactory.instance.makeAlertFactory()
    
    
    //MARK: - Outlets
    //MARK: - Public Properties
    //MARK: - Private Properties
    
    var arrOfGoods:[Good] = []
    
    
    //MARK: - Init
    //MARK: - LifeStyle ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        takeBasket()
        tableView.reloadData()
    }
    
    
    //MARK: - IBAction
    //MARK: - Public methods
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
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
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
        
        //        return cell
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
    
    
    //MARK: - Navigation
    
    


    

    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
