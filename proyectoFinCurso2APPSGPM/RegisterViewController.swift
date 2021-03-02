//
//  RegisterViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//
import UIKit

class RegisterViewController: UIViewController {
    
    //values
    @IBOutlet weak var userTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var confirmPasswordTf: UITextField!
    
    //actions
    @IBAction func registerBt(_ sender: UIButton) {
        //get data
        let user:String = userTf.text!
        let password:String = passwordTf.text!
        let confirmPassword:String = confirmPasswordTf.text!
        
        //check data
        if(user.isEmpty){
            //TODO warning of missing value
            return
        }
        else if(password.isEmpty){
            //TODO warning of missing value
            return
        }
        else if(confirmPassword.isEmpty){
            //TODO warning of missing value
            return
        }
        else if(password != confirmPassword){
            //TODO warning of missing value
            return
        }
        
        //send data
        registerRequest(user: user, password: password)
    }
    @IBAction func returnBt(_ sender: UIButton) {
        //TODO load log in screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func registerRequest(user:String, password:String){
        //Background call register
        DispatchQueue.global().async {
            DBAPIControlle.PostRegister()
            DispatchQueue.main.async {
                //TODO updte user interface
            }
        }
    }

}
