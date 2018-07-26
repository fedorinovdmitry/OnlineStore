import UIKit

class ListOfGoodsTableViewController: GoodsNetworkUIViewControllerDelegate  {

    //MARK: - Custom types
    //MARK: - Constants
    let requestFactoryToWorkWithGoods = RequestFactory.instance.makeRequestToWorkWithGoods()
    let userDefaults = PersonalCapDependenceFactory.instance.makeUserDefaults()
    let alertFactory = PersonalCapDependenceFactory.instance.makeAlertFactory()
    lazy var delegateGoodsNetworkC: GoodsNetworkControllerRequestsFactory =
        NetworkDelegateControllersBornFactory().makeGoodsNetworkControllerDelegate(controller: self)
    //MARK: - Outlets
    //MARK: - Public Properties
    //MARK: - Private Properties
    private var arrOfGoods:[Good] = []
    //MARK: - Init
    //MARK: - LifeStyle ViewController
    //MARK: - IBAction
    //MARK: - Public methods
    //MARK: - Private methods
    //MARK: - Navigation
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        takeCatalog ()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrOfGoods.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goodViewCell", for: indexPath) as! ListOfGoodsViewCell
        
        let good = arrOfGoods[indexPath.row]
        cell.nameOfGood.text = good.productName
        cell.price.text = String(good.productPrice)

        return cell
    }
    
    private func takeCatalog () {
        
        delegateGoodsNetworkC.takeCatalog(){ [weak self] arr in
            guard let listOfGoodTVC = self
            else {
                return
            }
            listOfGoodTVC.arrOfGoods = arr
            listOfGoodTVC.tableView.reloadData()
        }
        
    }

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
