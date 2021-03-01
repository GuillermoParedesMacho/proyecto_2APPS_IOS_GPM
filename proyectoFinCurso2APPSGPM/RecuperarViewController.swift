//
//  RecuperarViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//
import UIKit

class RecuperarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func RecoverRequest(){
        //Background call recover request	
        DispatchQueue.global().async {
            DBAPIControlle.PostRecoverPassword()
            DispatchQueue.main.async {
                //TODO updte user interface
            }
        }
    }

}

