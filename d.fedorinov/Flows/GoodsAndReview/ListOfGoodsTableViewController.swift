import UIKit

class ListOfGoodsTableViewController: GoodsNetworkUIViewControllerDelegate  {

    //MARK: - Constants
    
    lazy var delegateGoodsNetworkC: GoodsNetworkControllerRequestsFactory =
        NetworkDelegateControllersBornFactory().makeGoodsNetworkControllerDelegate(controller: self)

    
    //MARK: - Private Properties
    
    private var arrOfGoods:[Good] = []

    
    //MARK: - LifeStyle ViewController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        takeCatalog()
        tableView.reloadData()
    }
    
    
    //MARK: - Private methods
    
    private func takeCatalog () {
        
        delegateGoodsNetworkC.takeCatalog(){ [weak self] arr in
            guard let listOfGoodTVC = self
            else { return }
            listOfGoodTVC.arrOfGoods = arr
            listOfGoodTVC.tableView.reloadData()
        }
        
    }
    
    private func configureCell(cell:ListOfGoodsViewCell, good:Good) -> ListOfGoodsViewCell {
        cell.nameOfGood.text = good.productName
        cell.price.text = String(good.productPrice)
        cell.goodId = good.id
        let quantity = good.quantity ?? 0
        cell.quantity.text = String(quantity)
        cell.controller = self
        return cell
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfGoods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "goodViewCell", for: indexPath) as! ListOfGoodsViewCell
        let good = arrOfGoods[indexPath.row]
        cell = configureCell(cell: cell, good: good)
        return cell
    }
    
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "toGoodPage" {
            let destination = segue.destination as? GoodCartViewController
            if let selectedRow = tableView.indexPathForSelectedRow?.row {
                destination?.good = arrOfGoods[selectedRow]
            }
        }
    }
}

