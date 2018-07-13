//
//  Good.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 09.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation


struct Good: Codable{
    let id: Int
    var productName: String
    var productPrice: Int
    init(id: Int, productName: String, productPrice: Int) {
        self.id = id
        self.productName = productName
        self.productPrice = productPrice
    }
}




