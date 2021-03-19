//
//  DBAPIController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
// https://console.firebase.google.com/project/proyecto2appsfincurso/authentication/users

import Foundation
import Firebase

class DBAPIControlle{
    
    //data needed for operations
    static private let urlApi = ""
    static private var token = ""
    static private let auth = Auth.auth()
    static private let dataBase = Database.database().reference()
    static private let usersDB = dataBase.child("Users")
    
    static private var DBcontroller = DatabaseController()
    
    //operations
    static public func GetlogIn(email:String, password:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:Error?) -> ()){
        auth.signIn(withEmail: email, password: password) { (authDataResult, error) in
            if(error != nil){ onError(error) }
            onSucseed()
        }
    }
    
    static public func PostChangePassword(password:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:Error?) -> ()){
        auth.currentUser?.updatePassword(to: password, completion: { (err) in
            if(err != nil){
                onError(err)
            }
            onSucseed()
        })
    }
    
    static public func PostRecoverPassword(email:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:Error?) -> ()){
        auth.sendPasswordReset(withEmail: email) { (err) in
            if (err != nil){
                onError(err)
            }
            onSucseed()
        }
    }
    
    static public func PostRegister(name:String, password:String, email:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:Error?) -> ()){
        auth.createUser(withEmail: email, password: password) { (authDataResult, error) in
            if(error != nil){ onError(error) }
            
            let uid = auth.currentUser?.uid
            usersDB.child(uid!).setValue(["name":name, "email":email])
            
            onSucseed()
        }
    }
    
    static public func GetUserData(onSucseed: @escaping (_ data:UserData) -> (), onError: @escaping (_ err:Error?) -> ()){
        let uid = auth.currentUser?.uid
        
        usersDB.child(uid!).observe(.value) { (snapshot) in
            if let diccionary = snapshot.value as? [String:Any]{
                onSucseed(UserData(name: diccionary["name"] as! String, email: diccionary["email"] as! String))
            }
        } withCancel: { (err) in
            onError(err)
        }

    }
    
    static public func logOut(onSucseed: @escaping () -> Void , onError: @escaping (_ err:Error?) -> ()) {
        do{	
            try auth.signOut()
        }catch let err as Error{
            onError(err)
        }
        onSucseed()
    }
    
    static public func PostDeleteUser(onSucseed: @escaping () -> Void , onError: @escaping (_ err:Error?) -> ()){
        auth.currentUser?.delete(completion: { (err) in
            if(err != nil){
                onError(err)
            }
            onSucseed()
        })
    }
    
    static public func PostContact(contactName:String) -> String{
        return DBcontroller.addContact(token: token, name: contactName)
    }
    
    static public func getContactList() -> contactsResponse{
        return DBcontroller.getContact(token: token)
    }
    
    //functions for operations
    
    //structures
    public struct UserData{
        let name: String
        let email: String
    }
    
    public struct contactsResponse{
        let response: String
        let contacts: [String]
    }
}
