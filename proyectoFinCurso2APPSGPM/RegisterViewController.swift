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
    @IBOutlet weak var emailTf: UITextField!
    
    //actions
    @IBAction func registerBt(_ sender: UIButton) {
        
        let user:String = userTf.text!
        let password:String = passwordTf.text!
        let confirmPassword:String = confirmPasswordTf.text!
        let email:String = emailTf.text!
        
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
        else if(email.isEmpty){
            //TODO warning of missing value
            return
        }
        else if(password != confirmPassword){
            //TODO warning of missing value
            return
        }
        
        //send data
        registerRequest(name: user, password: password, email: email)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //remove keyboard when touched
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func registerRequest(name:String, password:String, email:String){
        //Background call register
        DispatchQueue.global().async {
            DBAPIControlle.PostRegister(name: name, password: password, email: email)
            DispatchQueue.main.async {
                //TODO updte user interface
            }
        }
    }

}
