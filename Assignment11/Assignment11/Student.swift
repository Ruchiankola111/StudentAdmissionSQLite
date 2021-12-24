//
//  Employee.swift
//  NewNotes10
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation

class Student {
    
    
    var id : Int = 0
    var password : String = ""
    var name : String = ""
    var div : String = ""
    var phone: String = ""
    var email: String = ""
    
    init(){}
    init(id:Int,password:String, name:String ,div:String, phone:String, email:String)
    {
        self.id = id
        self.password = password
        self.name = name
        self.div = div
        self.phone = phone
        self.email = email
    }
}
