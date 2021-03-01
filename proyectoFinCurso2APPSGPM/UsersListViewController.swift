//
//  UsersListViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//
import UIKit

class UsersListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func RegisterRequest(){
        //Background get user list
        DispatchQueue.global().async {
            DBAPIControlle.GetUsersList()
            DispatchQueue.main.async {
                //TODO updte user interface
            }
        }
    }

}
