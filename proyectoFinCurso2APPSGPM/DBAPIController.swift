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
        if(data.isEmpty || data == "ERR - user not found"){return "User not found or password incorrect"}
        token = data
        return "ok"
    }
    
    static public func PostRecoverPassword(email:String) -> String{
        let data = DBcontroller.recoverPassword(email: email)
        if(data.isEmpty || data == "ERR - user not found"){return "User not found"}
        return data
    }
    
    static public func PostRegister(name:String, password:String, email:String) -> String{
        return DBcontroller.registerUser(name: name, password: password, email: email)
        
    }
    
    static public func GetUserData() -> userDataResponse{
        return DBcontroller.getUserData(token: token)
        
    }
    
    static public func PostDeleteUser() -> String{
        return DBcontroller.deleteUser(token: token)
    }
    
    static public func PostChangepassword(password:String) -> String{
        let data = DBcontroller.changePassword(token: token, password: password)
        if(data != "ok"){ return "User not found" }
        return "ok"
    }
    
    static public func PostContact(contactName:String) -> String{
        return DBcontroller.addContact(token: token, name: contactName)
    }
    
    static public func getContactList() -> contactsResponse{
        return DBcontroller.getContact(token: token)
    }
    
    //functions for operations
    
    //structures
    public struct userDataResponse{
        let response: String
        let name: String
        let email: String
    }
    
    public struct contactsResponse{
        let response: String
        let contacts: [String]
    }
}
