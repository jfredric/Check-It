//
//  ListsTableViewController.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 9/27/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import UIKit
import Firebase

class ListsTableViewController: UITableViewController {
    
    let showLoginSegueID = "showLoginSegue-ID"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //tableView.separatorColor = .clear
        //tableView.separatorStyle = .none
        
        // set listiner for login status, send to login screen if logged out.
        Auth.auth().addStateDidChangeListener() { auth, user in
            if let newUser = user { // user logged in
                print("logged in")
                Data.sharedInstance.configureForUser(user: newUser)
            } else { // send to log in screen
                print("user not logged in")
                //self.navigationController?.performSegue(withIdentifier: self.showLoginSegueID, sender: nil) // for push seque
                // segue modally to login screen
                let loginViewController = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(loginViewController, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Actions
    
    @IBAction func addSampleBarButtonTapped(_ sender: Any) {
        Data.sharedInstance.addSampleData()
        
        self.tableView.reloadData()
    }
    
    // Show an alert for text input when the user taps the add button in the nav bar
    @IBAction func addBarButtonTapped(_ sender: UIBarButtonItem) {
        // Create the Alert Controller
        let alertController = UIAlertController(title: "Add", message:
            "Enter a name for your list", preferredStyle: UIAlertControllerStyle.alert)
        
        // add text field for title/name
        alertController.addTextField { (textField) in
            textField.text = "" //default text. Change to empty after testing.
            textField.placeholder = "name of list"
        }
        
        // add the button actions - Left to right
        //    Cancel Button
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
        //    OK Button
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: { [weak alertController] (_) in
            let textField = alertController!.textFields![0] // Force unwrapping because we know it exists.
            let title = textField.text ?? ""
            print("add new list: \(title)")
            Data.sharedInstance.add(newList: ToDoList(name: title, description: ""))
            self.tableView.reloadData()
            }))
        
        // Present the Alert
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.sharedInstance.toDoLists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListsCellID", for: indexPath) as? ListsTableViewCell else {
            fatalError("The dequeued call is not a ListsTableViewCell")
        }

        // Configure the cell...
        cell.nameLabel.text = Data.sharedInstance.toDoLists[indexPath.row].name
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            confirmAlert(message: "Are you sure you want to delete '\(Data.sharedInstance.toDoLists[indexPath.row].name)' list?", from: self, forYes: { (_) in
                // Delete the row from the data source
                Data.sharedInstance.delete(at: indexPath.row)
                // Delet the row from the table view
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender) // is this needed?
        
        switch(segue.identifier ?? "") {
        case "ShowList":
            // Get the new view controller using segue.destinationViewController.
            guard let tasktableViewController = segue.destination as? TasksTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedListCell = sender as? ListsTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "nil_ListsTableViewCell")")
            }
            guard let indexPath = tableView.indexPath(for: selectedListCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            
            let selectedList: ToDoList = Data.sharedInstance.toDoLists[indexPath.row]
            
            // Pass the selected object to the new view controller.
            tasktableViewController.currentList = selectedList
        case self.showLoginSegueID :
            break // nothing to prepare
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "nil_defaultSegue")")
        }
        
    }
    

}
