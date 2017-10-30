//
//  ToDoList.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 10/27/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ToDoList {
    var name: String = "Name"
    var openTasks: [Task] = []
    private var openTasksIDs: [String] = []
    var closedTasks: [Task] = []
    private var closedTasksIDs: [String] = []
    var description: String = ""
    var showCompleted: Bool = false
    var listRef: DatabaseReference
    
    // Firebase Keys
    struct FirebaseKeys {
        static let name = "name"
        static let openTasks = "open-tasks"
        static let closedTasks = "closed-tasks"
        static let description = "task-description"
        static let showCompleted = "show-completed"
        static let listID = "list-id"
    }
    
    init(name newName: String, description newDesc: String) {
        name = newName
        description = newDesc
        listRef = AppDatabase.listDataRootRef.childByAutoId()
        listRef.setValue(toAnyObject())
    }
    
    init(from snapshot: DataSnapshot) {
        listRef = snapshot.ref
        let newListData = snapshot.value as! [String:Any]
        self.name = newListData[FirebaseKeys.name] as! String
        if let newDescription = newListData[FirebaseKeys.description] {
            self.description = newDescription as! String
        }
        self.showCompleted = newListData[FirebaseKeys.showCompleted] as! Bool
//            openTasksIDs = newListData[FirebaseKeys.openTasks] as! [String]
//            for taskID in openTasksIDs {
//                //init task data from id
//            }
//            closedTasksIDs = newListData[FirebaseKeys.closedTasks] as! [String]
//            for taskID in openTasksIDs {
//                //init task data from id
//            }
        self.listRef.removeAllObservers() // new so this should be the only observe

    }
    
    func completeTask(at taskIndex: Int) {
        if taskIndex >= openTasks.count {
            fatalError("out of bounds on 'openTasks'")
        }
        let completedTask = openTasks[taskIndex]
        completedTask.status = true
        closedTasks.insert(completedTask, at: 0)
        openTasks.remove(at: taskIndex)
    }
    
    func reOpenTask(at taskIndex: Int) {
        if taskIndex >= closedTasks.count {
            fatalError("out of bounds on 'closedTasks'")
        }
        let reopenedTask = closedTasks[taskIndex]
        reopenedTask.status = false
        openTasks.append(reopenedTask)
        closedTasks.remove(at: taskIndex)
    }
    
    //incomplete
    func toAnyObject() -> Any {
        return [
            FirebaseKeys.name : name,
            FirebaseKeys.openTasks : openTasksIDs,
            FirebaseKeys.closedTasks : openTasksIDs,
            FirebaseKeys.description : description,
            FirebaseKeys.showCompleted : showCompleted,
        ]
    }
    
}
