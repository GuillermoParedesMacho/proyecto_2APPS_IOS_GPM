//
//  SettingsViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 3/21/21.
//ChangePassword

import UIKit

class SettingsViewController:UIViewController{
    //values
    @IBOutlet weak var changeNameTf: UITextField!
    @IBOutlet weak var changeEmailTf: UITextField!
    
    //actions
    @IBAction func changeNameBt(_ sender: UIButton) {
        let name = changeNameTf.text!
        
        if(name.isEmpty){
            okBtpopup(title: "Error", text: "Name field is empty")
            return
        }
        
        changeName(name: name)
    }
    @IBAction func changeEmailBt(_ sender: UIButton) {
        let email = changeEmailTf.text!
        
        if(email.isEmpty){
            okBtpopup(title: "Error", text: "Email field is empty")
            return
        }
        
        changeEmail(email: email)
    }
    @IBAction func changePasswordBt(_ sender: UIButton) {
        performSegue(withIdentifier: "ChangePassword", sender: nil)
    }
    
    override func viewDidLoad() {
        //load user data on start
        userDataRequest()
        
        //remove keyboard when touched
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func userDataRequest(){
        DispatchQueue.global().async {
            FirebaseNetworkManager.GetUserData { (data) in
                DispatchQueue.main.async {
                    self.changeNameTf.text = data.name
                    self.changeEmailTf.text = data.email
                }
            } onError: { (err) in
                DispatchQueue.main.async {
                    self.okBtpopup(title: "Error", text: err)
                }
            }
        }
    }
    
    func changeName(name:String){
        DispatchQueue.global().async {
            FirebaseNetworkManager.PostChangeUserName(name: name) {
                DispatchQueue.main.async {
                    self.okBtpopup(title: "Mesage", text: "Name changed sucsessfully")
                }
            } onError: { (err) in
                DispatchQueue.main.async {
                    self.okBtpopup(title: "Error", text: err)
                }
            }

        }
    }
    
    func changeEmail(email:String){
        DispatchQueue.global().async {
            FirebaseNetworkManager.PostChangeEmail(email: email) {
                DispatchQueue.main.async {
                    self.okBtpopup(title: "Mesage", text: "Name changed sucsessfully")
                }
            } onError: { (err) in
                DispatchQueue.main.async {
                    self.okBtpopup(title: "Error", text: err)
                }
            }

        }
    }
    
    func okBtpopup(title:String, text:String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style:.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
