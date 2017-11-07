//
//  TasksTableViewCell.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 9/27/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    var selectedTask: Task!
    var currentList: ToDoList!
    var taskIndex: Int?
    var updateTasksTable: (() -> ())?
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var checkBoxImage: UIImageView!
    @IBOutlet weak var taskNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func checkBoxSelected(_ sender: UIButton) {
        //selectedTask.status = !selectedTask.status
        if !selectedTask.status {
            currentList.completeTask(at: taskIndex!)
        } else {
            currentList.reOpenTask(at: taskIndex!)
        }
        updateOutlets()
        
        // call back to tableview to reload data
        // updateTasksTable!() Handle by Model now
        
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTaskData"),object: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateOutlets() {
        
        taskNameLabel.text = selectedTask.title
        
        if selectedTask.status { //completed
            taskNameLabel.textColor = UIColor.lightGray
            checkBoxImage.image = UIImage(named: "Checkbox Checked")
        } else { // incomplete
            taskNameLabel.textColor = UIColor.black
            checkBoxImage.image = UIImage(named: "Checkbox Unchecked")
        }
    }

}
