//
//  LoginViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    //values
    @IBOutlet weak var userTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    //actions
    @IBAction func loginBt(_ sender: UIButton) {
        //getting data
        let user:String = userTf.text!
        let password:String = passwordTf.text!
        
        //cheking data
        if(user.isEmpty){
            //TODO warning of value empty
            return
        }
        else if(password.isEmpty){
            //TODO warning of value empty
            return
        }
        
        //call api
        logInRequest(user: user, password: password)
        
    }
    @IBAction func registerBt(_ sender: UIButton) {
        //TODO load register screen
    }
    @IBAction func recoverBt(_ sender: UIButton) {
        //TODO load recover screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func logInRequest(user:String, password:String){
        //Background call log in
        DispatchQueue.global().async {
            DBAPIControlle.GetlogIn()
            DispatchQueue.main.async {
                //TODO updte user interface
            }
        }
    }


}
