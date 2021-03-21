//
//  DBAPIController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
// https://console.firebase.google.com/project/proyecto2appsfincurso/authentication/users

import Foundation
import Firebase

class FirebaseNetworkManager{
    
    //data needed for operations
    static private let urlApi = ""
    static private var token = ""
    static private let auth = Auth.auth()
    static private let dataBase = Database.database().reference()
    static private let usersDB = dataBase.child("Users")
    
    //operations
    static public func GetlogIn(email:String, password:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()){
        auth.signIn(withEmail: email, password: password) { (authDataResult, error) in
            if(error != nil){
                onError(error!.localizedDescription)
                return
            }
            onSucseed()
        }
    }
    
    static public func PostChangeUserName(name:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()){
        let uid = auth.currentUser?.uid
        if(uid == nil){
            onError("User not found")
            return
        }
        usersDB.child(uid!).updateChildValues(["name":name])
        onSucseed()
    }
    
    static public func PostChangeEmail(email:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()){
        auth.currentUser?.updateEmail(to: email, completion: { (err) in
            if(err != nil){
                onError(err!.localizedDescription)
                return
            }
            
            let uid = auth.currentUser?.uid
            if(uid == nil){ onError("User not found") }
            usersDB.child(uid!).updateChildValues(["email":email])
            onSucseed()
        })
    }
    
    static public func PostChangePassword(password:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()){
        auth.currentUser?.updatePassword(to: password, completion: { (err) in
            if(err != nil){
                onError(err!.localizedDescription)
                return
            }
            onSucseed()
        })
    }
    
    static public func PostRecoverPassword(email:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()){
        auth.sendPasswordReset(withEmail: email) { (err) in
            if (err != nil){
                onError(err!.localizedDescription)
                return
            }
            onSucseed()
        }
    }
    
    static public func PostRegister(name:String, password:String, email:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()){
        auth.createUser(withEmail: email, password: password) { (authDataResult, err) in
            if(err != nil){
                onError(err!.localizedDescription)
                return
            }
            
            let uid = auth.currentUser?.uid
            if(uid == nil){ onError("User not found") }
            usersDB.child(uid!).setValue(["name":name, "email":email])
            onSucseed()
        }
    }
    
    static public func GetUserData(onSucseed: @escaping (_ data:UserData) -> (), onError: @escaping (_ err:String) -> ()){
        let uid = auth.currentUser?.uid
        if(uid == nil){onError("User not found")}
        
        usersDB.child(uid!).observe(.value) { (snapshot) in
            if let diccionary = snapshot.value as? [String:Any]{
                onSucseed(UserData(name: diccionary["name"] as! String, email: diccionary["email"] as! String))
            }
        } withCancel: { (err) in
            onError(err.localizedDescription)
        }

    }
    
    static public func logOut(onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()) {
        do{	
            try auth.signOut()
        }catch let err as Error{
            onError(err.localizedDescription)
            return
        }
        onSucseed()
    }
    
    static public func PostDeleteUser(onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()){
        let uid = auth.currentUser?.uid
        if(uid == nil){onError("User not found")}
        
        usersDB.child(uid!).removeValue()
        onSucseed()
        auth.currentUser?.delete(completion: { (err) in
            if(err != nil){
                onError(err!.localizedDescription)
                return
            }
            onSucseed()
        })
    }
    
    static public func PostAddContact(contactName:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()){
        
    }
    
    static public func PostRemoveContact(contactName:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()){
        
    }
    
    static public func getContactList(onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()){
        getContactList(filter:"") {
            onSucseed()
        } onError: { (err) in
            onError(err)
        }
    }
    static public func getContactList(filter:String, onSucseed: @escaping () -> Void , onError: @escaping (_ err:String) -> ()){
        
    }
    
    static public func getUsersList(onSucseed: @escaping (_ userList:Array<UserData>) -> () , onError: @escaping (_ err:String) -> ()){
        getUsersList(filter:"") {(data) in
            onSucseed(data)
        } onError: { (err) in
            onError(err)
        }

    }
    static public func getUsersList(filter:String, onSucseed: @escaping (_ userList:Array<UserData>) -> () , onError: @escaping (_ err:String) -> ()){
        var user:UserData? = nil
        GetUserData { (userData) in
            user = userData
        
            var response:Array<UserData> = []
            usersDB.observeSingleEvent(of: .value) { (snapshot) in
                if(snapshot.childrenCount > 0){
                    for dataGroup in snapshot.children.allObjects as! [DataSnapshot]{
                        if let data = dataGroup.value as? [String: Any]{
                            let email = data["email"] as! String
                            if(email != user?.email){
                                response.append(UserData(name: data["name"] as! String, email: data["email"] as! String))
                            }
                        }
                    }
                }
                onSucseed(response)
            }
        } onError: { (err) in
            onError(err)
            return
        }
        
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
