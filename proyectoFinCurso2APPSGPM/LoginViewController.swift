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
        logInRequest(name: user, password: password)
        
    }
    @IBAction func registerBt(_ sender: UIButton) {
        performSegue(withIdentifier: "recoverPassword", sender: nil)
    }
    @IBAction func recoverBt(_ sender: UIButton) {
        performSegue(withIdentifier: "register", sender: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()//Looks for single or multiple taps.
        
        //remove keyboard when touched
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func logInRequest(name:String, password:String){
        //Background call log in
        DispatchQueue.global().async {
            let data = DBAPIControlle.GetlogIn(name: name, password: password)
            DispatchQueue.main.sync {
                //TODO gestionar alertas
                let alert = UIAlertController(title: "data", message: data, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "data", style:.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}
