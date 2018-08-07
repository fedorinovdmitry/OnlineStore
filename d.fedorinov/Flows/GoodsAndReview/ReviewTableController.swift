import UIKit

///Менеджер по работе с таблвью
class ReviewTableController: NSObject {
    
    let cellReuseID = "reviewCell"
    weak var tableView: UITableView?
    var reviews: [Review]?
    
    init(tableView: UITableView, reviews: [Review]) {
        super.init()
        
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.reviews = reviews
    }
    
}


extension ReviewTableController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as? ReviewTableViewCell,
              let reviews = reviews
        else {
            assertionFailure("Review Cell cast guard")
            return UITableViewCell()
        }
        
        let review = reviews[indexPath.row]
        cell.idUser.text = String(review.idUser)
        cell.textOfReview.text = review.text
        
        return cell
    }

}
