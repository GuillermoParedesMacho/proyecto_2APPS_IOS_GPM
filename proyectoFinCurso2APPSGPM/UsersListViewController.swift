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
    @IBOutlet weak var searchTf: UITextField!
    var contacts:[FirebaseNetworkManager.ListedUserData] = []
    
    //actions
    @IBAction func searchBt(_ sender: UIButton) {
        let searchName = searchTf.text!
        usersListRequest(filter: searchName)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //table stuff
        usersListTv.delegate = self
        usersListTv.dataSource = self
        
        //remove keyboard when touched
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //request and update
        usersListRequest(filter: "")
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func addContact(contact:FirebaseNetworkManager.ListedUserData){
        //Background add contact
        DispatchQueue.global().async {
            FirebaseNetworkManager.PostAddContact(contact: contact) {
                DispatchQueue.main.async {
                    self.okBtpopup(title: "Message", text: "Contact added sucsessfully")
                }
            } onError: { (err) in
                DispatchQueue.main.async {
                    self.okBtpopup(title: "Error", text: err)
                }
            }

        }
    }
    
    func usersListRequest(filter:String){
        //Background get user list
        DispatchQueue.global().async {
            FirebaseNetworkManager.GetUsersList(filter: filter) { (userData) in
                DispatchQueue.main.async {
                    self.contacts = userData
                    self.usersListTv.reloadData()
                    self.usersListTv.endUpdates()
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

extension UsersListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Message", message: "you want to add " + contacts[indexPath.row].name + " to your contacts?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style:.default, handler: { (action) in
            self.addContact(contact: self.contacts[indexPath.row])
        }))
        alert.addAction(UIAlertAction(title: "No", style:.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UsersListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userContact", for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row].name
        
        return cell
    }
}
