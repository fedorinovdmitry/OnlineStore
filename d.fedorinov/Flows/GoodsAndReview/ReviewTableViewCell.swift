import UIKit


///Ячейка отзыва
class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var idUser: UILabel!
    
    @IBOutlet weak var textOfReview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textOfReview.isEditable = false
        
    }
}

