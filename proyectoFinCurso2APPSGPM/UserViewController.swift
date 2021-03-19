//
//  UserViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//
import UIKit

class UserViewController: UIViewController {
    
    //values
    @IBOutlet weak var userDataLb: UILabel!
    
    //actions
    @IBAction func deleteUserBt(_ sender: UIButton) {
        let alert = UIAlertController(title: "Message", message: "are you sure you want to delete your user?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style:.default, handler: { (action) in
            self.deleteUserRequest()
        }))
        alert.addAction(UIAlertAction(title: "No", style:.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func changePasswordBt(_ sender: UIButton) {
        performSegue(withIdentifier: "ChangePassword", sender: nil)
    }
    @IBAction func logOutBt(_ sender: UIButton) {
        DispatchQueue.global().async {
            DBAPIControlle.logOut {
                DispatchQueue.main.sync {
                    self.performSegue(withIdentifier: "logIn", sender: nil)
                }
            } onError: { (err) in
                DispatchQueue.main.sync {
                    self.okBtpopup(title: "Error", text: err.debugDescription)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDataRequest()
    }

    func userDataRequest(){
        //Background get user data
        DispatchQueue.global().async {
            DBAPIControlle.GetUserData { (data) in
                let text = "Name: " + data.name + "\nEmail: " + data.email
                self.userDataLb.text = text
            } onError: { (err) in
                self.okBtpopup(title: "Error", text: err.debugDescription)
            }
        }
    }
    
    func deleteUserRequest(){
        //Background call delete user
        DispatchQueue.global().async {
            DBAPIControlle.PostDeleteUser {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Message", message: "User deleted, bye", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ok", style:.default, handler: { (action) in
                        self.performSegue(withIdentifier: "logIn", sender: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            } onError: { (err) in
                DispatchQueue.main.async {
                    self.okBtpopup(title: "Error", text: err!.localizedDescription)
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
