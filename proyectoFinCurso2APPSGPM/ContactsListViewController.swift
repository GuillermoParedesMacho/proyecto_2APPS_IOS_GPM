//
//  ContactsListViewController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 3/21/21.
//

import UIKit

class ContactsListViewController:ViewController{
    //values
    @IBOutlet weak var contactsTv: UITableView!
    @IBOutlet weak var searchTf: UITextField!
    var contacts:[FirebaseNetworkManager.ListedUserData] = []
    
    //actions
    @IBAction func searchBt(_ sender: UIButton) {
        let filter = searchTf.text!
        contactsListRequest(filter: filter)
    }
    
    override func viewDidLoad() {
        //table stuff
        contactsTv.delegate = self
        contactsTv.dataSource = self
        
        //remove keyboard when touched
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //reuest and update
        contactsListRequest(filter: "")
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func removeContact(contact:FirebaseNetworkManager.ListedUserData){
        //Background add contact
        DispatchQueue.global().async {
            FirebaseNetworkManager.PostRemoveContact(contact: contact) {
                DispatchQueue.main.async {
                    self.okBtpopup(title: "Message", text: "Contact removed sucsessfully")
                    self.contactsListRequest(filter: "")
                }
            } onError: { (err) in
                DispatchQueue.main.async {
                    self.okBtpopup(title: "Error", text: err)
                }
            }

        }
    }
    
    func contactsListRequest(filter:String){
        //Background get user list
        DispatchQueue.global().async {
            FirebaseNetworkManager.GetContactList(filter: filter) { (userData) in
                DispatchQueue.main.async {
                    self.contacts = userData
                    self.contactsTv.reloadData()
                    self.contactsTv.endUpdates()
                }
            } onError: { (err) in
                DispatchQueue.main.async {
                    self.okBtpopup(title: "ERROR", text: err)
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


extension ContactsListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Message", message: "you want to add " + contacts[indexPath.row].name + " to your contacts?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style:.default, handler: { (action) in
            self.removeContact(contact: self.contacts[indexPath.row])
        }))
        alert.addAction(UIAlertAction(title: "No", style:.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ContactsListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userContact", for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row].name
        
        return cell
    }
}
