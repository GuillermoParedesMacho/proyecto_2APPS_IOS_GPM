//
//  DatabaseController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 3/7/21.
//

import Foundation

class  DatabaseController{
    
    private var users: Array<UserController> = Array()
    private var userContactRelation: Array<UserContactRelation> = Array()
    
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
                var contactsToRemove: Array<String> = Array()
                for contact in userContactRelation{
                    if(contact.userName == user.name){
                        contactsToRemove.append(contact.contactName)
                    }
                }
                for contact in contactsToRemove{
                    let data = deleteContact(token: token, contactName: contact)
                    if(data != "ok"){
                        return data
                    }
                }
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
    
    //anadir nuevo contacto
    public func addContact(token:String, name:String) -> String{
        for user in users{
            if(user.token == token){
                if(user.name == name){
                    return "You can't add yourselfe to your contacts"
                }
                for contact in users{
                    if (contact.name == name){
                        for existingContact in userContactRelation{
                            if(existingContact.userName == user.name && existingContact.contactName == contact.name){
                                return "Contact alredy exist"
                            }
                        }
                        userContactRelation.append(UserContactRelation(userName: user.name, contactName: contact.name))
                        return "ok"
                    }
                }
                return "Contact not found"
            }
        }
        return "User not found"
    }
    
    public func getContact(token:String) -> DBAPIControlle.contactsResponse{
        for user in users{
            if(user.token == token){
                var contacts:Array<String> = Array()
                for contact in userContactRelation{
                    if(contact.userName == user.name){
                        contacts.append(contact.contactName)
                    }
                }
                return DBAPIControlle.contactsResponse(response: "ok", contacts: contacts)
            }
        }
        return DBAPIControlle.contactsResponse(response: "ERR - User not found", contacts: [])
    }
    
    public func deleteContact(token:String, contactName:String) -> String{
        for user in users{
            if(user.token == token){
                var x = 0
                for contact in userContactRelation{
                    if(contact.userName == user.name && contact.contactName == contactName){
                        userContactRelation.remove(at: x)
                        return "ok"
                    }
                    x = x + 1
                }
                return "contact not found"
            }
        }
        return "user not found"
    }
}
