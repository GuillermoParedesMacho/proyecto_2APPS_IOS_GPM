//
//  DBAPIController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//

import Foundation

class DBAPIControlle{
    
    //data needed for operations
    static private let urlApi = ""
    static private var token = ""
    
    static private var DBcontroller = DatabaseController()
    
    //operations
    //nota: debido a que no se pudo preparar una base de datos, las peticiones se han falseado
    static public func GetlogIn(name:String, password:String) -> String{
        let data = DBcontroller.logInUser(name: name, password: password)
        if(data.isEmpty || data == "ERR - user not found"){return "User or password not found"}
        token = data
        return "ok"
    }
    
    static public func PostRecoverPassword(email:String) -> String{
        return DBcontroller.recoverPassword(email: email)
        
    }
    
    static public func PostRegister(name:String, password:String, email:String) -> String{
        return DBcontroller.registerUser(name: name, password: password, email: email)
        
    }
    
    static public func GetUsersList(){
        //TODO preparar request
        
    }
    
    static public func GetUserData() -> userDataResponse{
        return DBcontroller.getUserData(token: token)
        
    }
    
    static public func PostDeleteUser() -> String{
        return DBcontroller.deleteUser(token: token)
    }
    
    //functions for operations
    
    //structures
    public struct userDataResponse{
        let response: String
        let name: String
        let email: String
    }
}
