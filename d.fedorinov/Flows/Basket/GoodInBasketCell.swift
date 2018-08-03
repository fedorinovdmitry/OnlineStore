//
//  GoodInBasketCell.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 02.08.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class GoodInBasketCell: UITableViewCell {

    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var goodPrice: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
