
//
//  TasksTableViewController.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 9/27/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {
    
    var currentList: ToDoList = ToDoList(name: "", description: "") // current to do list

    @IBOutlet weak var navBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navBar.title = currentList.name
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: Actions
    
    @IBAction func addNavButtonTapped(_ sender: Any) {
        // Create the Alert Controller
        let alertController = UIAlertController(title: "Add", message:
            "enter a description for you last", preferredStyle: UIAlertControllerStyle.alert)
        
        // add text field for title/name
        alertController.addTextField { (textField) in
            textField.text = "Task to do" //default text. Change to empty after testing.
            textField.placeholder = "Task to do"
        }
        
        // add the button actions - Left to right
        //    Cancel Button
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
        //    OK Button
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: { [weak alertController] (_) in
            let textField = alertController!.textFields![0] // Force unwrapping because we know it exists.
            let title = textField.text ?? ""
            print("add new tasks to \(self.currentList.name): \(title)")
            self.currentList.openTasks.append(Task(title: title, description: "", status: false))
            // update table
            self.tableView.reloadData()
        }))
        
        // Present the Alert
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentList.openTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCellID", for: indexPath) as? TasksTableViewCell else {
            fatalError("The dequeued call is not a TasksTableViewCell")
        }

        // Configure the cell...
        cell.selectedTask = currentList.openTasks[indexPath.row]
        cell.updateOutlets()

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
            confirmAlert(message: "Are you sure you want to delete task '\(currentList.openTasks[indexPath.row].title)'?", from: self, forYes: { (_) in
                // Delete the row from the data source
                self.currentList.openTasks.remove(at: indexPath.row)
                // Delete the row from the tableView
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
        } else if editingStyle == .insert { // how is this used???
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
    */

}
