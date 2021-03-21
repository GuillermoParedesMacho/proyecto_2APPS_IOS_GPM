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
            okBtpopup(title: "Error", text: "name field is empty")
            return
        }
        else if(password.isEmpty){
            okBtpopup(title: "Error", text: "password field is empty")
            return
        }
        else if(confirmPassword.isEmpty){
            okBtpopup(title: "Error", text: "confirm passwod field is empty")
            return
        }
        else if(email.isEmpty){
            okBtpopup(title: "Error", text: "email field is empty")
            return
        }
        else if(password != confirmPassword){
            okBtpopup(title: "Error", text: "the passwords are not the same")
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
            FirebaseNetworkManager.PostRegister(name: name, password: password, email: email) {
                self.okBtpopup(title: "Message", text: "New user registered\nWelcome to the app :)")
            } onError: { (err) in
                self.okBtpopup(title: "Error", text: err)
            }

        }
    }
    
    func okBtpopup(title:String, text:String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style:.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
