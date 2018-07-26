import UIKit

class ListOfGoodsTableViewController: GoodsNetworkUIViewControllerDelegate  {

    //MARK: - Constants
    let requestFactoryToWorkWithGoods = RequestFactory.instance.makeRequestToWorkWithGoods()
    let userDefaults = PersonalCapDependenceFactory.instance.makeUserDefaults()
    let alertFactory = PersonalCapDependenceFactory.instance.makeAlertFactory()
    lazy var delegateGoodsNetworkC: GoodsNetworkControllerRequestsFactory =
        NetworkDelegateControllersBornFactory().makeGoodsNetworkControllerDelegate(controller: self)

    
    //MARK: - Private Properties
    
    private var arrOfGoods:[Good] = []

    
    //MARK: - LifeStyle ViewController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        takeCatalog ()
    }
    
    
    //MARK: - Private methods
    
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
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfGoods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goodViewCell", for: indexPath) as! ListOfGoodsViewCell
        
        let good = arrOfGoods[indexPath.row]
        cell.nameOfGood.text = good.productName
        cell.price.text = String(good.productPrice)

        return cell
    }
    
    

}
