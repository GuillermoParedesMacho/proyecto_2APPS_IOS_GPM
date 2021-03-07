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
            if(name == user.name){ return "User alredy exist" }
            if(email == user.email){ return "Email alredy taken" }
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
    
    //recuperar contraseña
    public func recoverPassword(email:String) -> String{
        for user in users{
            if(email == user.email){return user.password}
        }
        return "ERR - user not found"
    }
    
    //obtener datos del usuario
    public func getUserData(token:String) -> DBAPIControlle.userDataResponse{
        for user in users{
            if(token == user.token){ return DBAPIControlle.userDataResponse(response: "ok", name: user.name, email: user.email) }
        }
        return DBAPIControlle.userDataResponse(response: "ERR - User not found", name: "", email: "")
    }
    
    //eliminar al usuario
    public func deleteUser(token:String) -> String{
        var x = 0
        for user in users{
            if(user.token == token){
                users.remove(at: x)
                return "ok"
            }
            x = x + 1
        }
        return "ERR - user not found"
    }
    
    //cambiar contrasena
    public func changePassword(token:String, password:String) -> String{
        for user in users{
            if(token == user.token){
                user.password = password
                return "ok"
                
            }
        }
        return "ERR - user not found"
    }
}
