//
//  User.swift
//  d.fedorinov
//
//  Created by Дмитрий Федоринов on 05.07.2018.
//  Copyright © 2018 Дмитрий Федоринов. All rights reserved.
//

import Foundation


class User{
    var id: Int
    var userName: String
    var password: String
    var email: String
    var gender: String
    var credit_car: String
    var bio: String
    init(id:Int, userName:String, password:String, email:String, gender: String, credit_car: String, bio: String) {
        self.id = id
        self.userName = userName
        self.password = password
        self.email = email
        self.gender = gender
        self.credit_car = credit_car
        self.bio = bio
    }
    
}


