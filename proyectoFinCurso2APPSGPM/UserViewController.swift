//
//  UserViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//
import UIKit

class UserViewController: UIViewController {
    
    //values
    
    //actions
    @IBAction func deleteUserBt(_ sender: UIButton) {
        deleteUserRequest()
        //TODO load log in if sucseed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDataRequest()
        // Do any additional setup after loading the view.
    }

    func userDataRequest(){
        //Background get user data
        DispatchQueue.global().async {
            DBAPIControlle.GetUserData()
            DispatchQueue.main.async {
                //TODO updte user interface
            }
        }
    }
    
    func deleteUserRequest(){
        //Background call delete user
        DispatchQueue.global().async {
            DBAPIControlle.PostDeleteUser()
            DispatchQueue.main.async {
                //TODO updte user interface
            }
        }
    }

}
