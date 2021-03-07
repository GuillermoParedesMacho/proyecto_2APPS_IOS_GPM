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
        deleteUserRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDataRequest()
    }

    func userDataRequest(){
        //Background get user data
        DispatchQueue.global().async {
            let data = DBAPIControlle.GetUserData()
            DispatchQueue.main.async {
                if(data.response != "ok"){
                    self.okBtpopup(title: "Error", text: data.response)
                }
                else{
                    let text = "User Name: " + data.name + "\nEmail: " + data.email
                    self.userDataLb.text = text
                }
            }
        }
    }
    
    func deleteUserRequest(){
        //Background call delete user
        DispatchQueue.global().async {
            let data = DBAPIControlle.PostDeleteUser()
            DispatchQueue.main.sync {
                if(data != "ok"){
                    self.okBtpopup(title: "Error", text: data)
                }
                else{
                    let alert = UIAlertController(title: "Message", message: "User deleted, bye", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ok", style:.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now()){
                        alert.dismiss(animated: true, completion: {
                            self.performSegue(withIdentifier: "logIn", sender: nil)
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
