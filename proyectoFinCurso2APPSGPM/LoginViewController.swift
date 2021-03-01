//
//  LoginViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func logInRequest(){
        //Background call log in
        DispatchQueue.global().async {
            DBAPIControlle.GetlogIn()
            DispatchQueue.main.async {
                //TODO updte user interface
            }
        }
    }


}
