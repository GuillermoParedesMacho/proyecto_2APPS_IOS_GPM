//
//  RecuperarViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//
import UIKit

class RecuperarViewController: UIViewController {
    
    //values
    @IBOutlet weak var emailTf: UITextField!
    
    //actions
    @IBAction func recoverBt(_ sender: UIButton) {
        //get data
        let email:String = emailTf.text!
        
        //check data
        if(email.isEmpty){
            self.okBtpopup(title: "Error", text: "email field is empty")
            return
        }
        
        //make request
        recoverRequest(email: email)
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

    func recoverRequest(email:String){
        //Background call recover request	
        DispatchQueue.global().async {
            FirebaseNetworkManager.PostRecoverPassword(email: email) {
                DispatchQueue.main.async {
                    self.okBtpopup(title: "Message", text: "Email sended for password recovery")
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

