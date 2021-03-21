//
//  UsersListViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//
import UIKit

class UsersListViewController: UIViewController {
    //values
    @IBOutlet weak var usersListTv: UITableView!
    @IBOutlet weak var contactNameTf: UITextField!
    
    //actions
    @IBAction func addContactBt(_ sender: UIButton) {
        let contactName:String = contactNameTf.text!
        
        if(contactName.isEmpty){
            okBtpopup(title: "Error", text: "Contact name is empty")
            return
        }
        
        addContact(contactName: contactName)
    }
    
    var contacts:[String] = []
    //let test = ["test1","test2","test3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //table stuff
        usersListTv.delegate = self
        usersListTv.dataSource = self
        
        //request and update
        usersListRequest()
        
        //remove keyboard when touched
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func addContact(contactName:String){
        //Background add contact
        DispatchQueue.global().async {
            let data = FirebaseNetworkManager.PostContact(contactName: contactName)
            DispatchQueue.main.sync {
                if(data != "ok"){
                    self.okBtpopup(title: "ERROR", text: data)
                }
                else{
                    self.usersListRequest()
                }
            }
        }
    }
    
    func usersListRequest(){
        //Background get user list
        DispatchQueue.global().async {
            let data = FirebaseNetworkManager.getContactList()
            DispatchQueue.main.sync {
                if(data.response != "ok"){
                    self.okBtpopup(title: "ERROR", text: data.response)
                }
                else{
                    self.contacts = data.contacts
                    self.usersListTv.reloadData()
                    self.usersListTv.endUpdates()
                    
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

extension UsersListViewController:UITableViewDelegate{
    
}

extension UsersListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userContact", for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row]
        
        return cell
    }
}
