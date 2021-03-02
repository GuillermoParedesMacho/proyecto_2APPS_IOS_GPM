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
            //TODO warn user about missing values
            return
        }
        
        //make request
        recoverRequest(email: email)
    }
    @IBAction func returnBt(_ sender: Any) {
        //TODO load log in screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func recoverRequest(email:String){
        //Background call recover request	
        DispatchQueue.global().async {
            DBAPIControlle.PostRecoverPassword()
            DispatchQueue.main.async {
                //TODO updte user interface
            }
        }
    }

}

