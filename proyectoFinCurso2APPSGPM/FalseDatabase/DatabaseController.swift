//
//  DatabaseController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 3/7/21.
//

import Foundation

class  DatabaseController{
    
    private var users: Array<UserController> = Array()
    
    //busqueda de usuario ya existente y crear nuevo usuario
    public func registerUser(name:String, password:String, email:String) -> String{
        for user in users{
            if(name == user.name){ return "user alredy exist" }
            if(email == user.email){ return "email alredy taken" }
        }
        users.append(UserController(name: name, password: password, email: email))
        return "ok"
    }
    
    //identificar al usuario y crear token
    public func logInUser(name:String, password:String) -> String{
        for user in users{
            if(name == user.name && password == user.password){
                let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
                let token = String((0..<64).map{ _ in letters.randomElement()! })
                user.token = token
                return token
            }
        }
        return "ERR - user not found"
    }
}
