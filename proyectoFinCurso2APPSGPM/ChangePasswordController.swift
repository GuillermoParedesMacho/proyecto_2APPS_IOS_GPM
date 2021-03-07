//
//  ChangePasswordController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 3/7/21.
//

import UIKit

class ChangePasswordController: UIViewController {
    //values
    @IBOutlet weak var newPasswordTf: UITextField!
    @IBOutlet weak var newPasswordConfirmTf: UITextField!
    
    //actions
    @IBAction func acceptBt(_ sender: UIButton) {
        let newPassword:String = newPasswordTf.text!
        let newPasswodConfirm:String = newPasswordConfirmTf.text!
        
        if(newPassword.isEmpty){
            okBtpopup(title: "Error", text: "password field is empty")
            return
        }
        else if(newPasswodConfirm.isEmpty){
            okBtpopup(title: "Error", text: "confirm passwod field is empty")
            return
        }
        else if(newPassword != newPasswodConfirm){
            okBtpopup(title: "Error", text: "the paswords aren't the same")
            return
        }
        
        changePasswordRequest(password: newPassword)
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
    
    func changePasswordRequest(password:String){
        //Background call log in
        DispatchQueue.global().async {
            let data = DBAPIControlle.PostChangepassword(password: password)
            DispatchQueue.main.sync {
                if(data != "ok"){
                    self.okBtpopup(title: "Error", text: data)
                }
                else{
                    let alert = UIAlertController(title: "Message", message: "password changed sucsessfully", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ok", style:.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now()){
                        alert.dismiss(animated: true, completion: {
                            self.performSegue(withIdentifier: "mainApp", sender: nil)
                        })
                    }
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
