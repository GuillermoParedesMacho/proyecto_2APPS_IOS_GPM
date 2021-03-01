//
//  UserViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//
import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func UseerDataRequest(){
        //Background get user data
        DispatchQueue.global().async {
            DBAPIControlle.GetUserData()
            DispatchQueue.main.async {
                //TODO updte user interface
            }
        }
    }
    
    func DeleteUserRequest(){
        //Background call delete user
        DispatchQueue.global().async {
            DBAPIControlle.PostDeleteUser()
            DispatchQueue.main.async {
                //TODO updte user interface
            }
        }
    }

}
