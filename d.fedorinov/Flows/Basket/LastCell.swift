//
//  LastCell.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 02.08.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class LastBasketCell: BasketNetworkControllerDelegateToCell {

    
    //MARK: - Constants
    
    let alertFactory = PersonalCapDependenceFactory.instance.makeAlertFactory()
    lazy var delegateBasketNetworkController: BasketNetworkinCell? = NetworkDelegateControllersBornFactory().makeBasketNetworkControllerDelegate(viewController: self)
    
    
    @IBOutlet weak var totalPrice: UILabel!
    
    var controller:UITableViewController? = nil
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
