//
//  UserController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 3/7/21.
//

import Foundation

class UserController{
    //data
    public var name:String = ""
    public var password:String = ""
    public var email:String = ""
    public var token:String = ""
    
    //funcs
    public init (name:String, password:String, email:String){
        self.name = name
        self.password = password
        self.email = email
    }
}
 
