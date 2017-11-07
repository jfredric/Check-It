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
    var name: String
    var description: String
    private var _showCompleted: Bool
    var showCompleted: Bool {
        get {
            return _showCompleted
        }
        set {
            _showCompleted = newValue
            listRef.child(FirebaseKeys.showCompleted).setValue(_showCompleted)
        }
    }
    
    
    var openTasks: [Task]
    private var openTasksIDs: [String]
    var closedTasks: [Task]
    private var closedTasksIDs: [String]
    
    var listRef: DatabaseReference
    
    // Controller Delegate
    var listDelegate: ListDataViewDelegate!
    
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
        _showCompleted = false
        openTasks = []
        openTasksIDs = []
        closedTasks = []
        closedTasksIDs = []
        listRef = AppDatabase.listDataRootRef.childByAutoId()
        listRef.setValue(toAnyObject())
    }
    
    init(from snapshot: DataSnapshot) {
        
        // initialize properties
        listRef = snapshot.ref
        let newListData = snapshot.value as! [String:Any]
        name = newListData[FirebaseKeys.name] as! String
        if let newDescription = newListData[FirebaseKeys.description] {
            description = newDescription as! String
        } else {
            description = ""
        }
        _showCompleted = newListData[FirebaseKeys.showCompleted] as! Bool
        if let tasks = newListData[FirebaseKeys.openTasks] as? [String] {
            openTasksIDs = tasks
        } else {
            openTasksIDs = []
        }
        openTasks = []
        if let tasks = newListData[FirebaseKeys.closedTasks] as? [String] {
            closedTasksIDs = tasks
        } else {
            closedTasksIDs = []
        }
        closedTasks = []
        
        // load tasks
        for taskID in openTasksIDs {
            //init task data from id
            let taskRef = AppDatabase.taskDataRootRef.child(taskID)
            taskRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let loadedTask = Task(from: snapshot)
                self.openTasks.append(loadedTask)
            })
        }
        for taskID in closedTasksIDs {
            //init task data from id
            let taskRef = AppDatabase.taskDataRootRef.child(taskID)
            taskRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let loadedTask = Task(from: snapshot)
                self.closedTasks.append(loadedTask)
            })
        }
    }
    
    func add(newTask: Task) {
        openTasks.append(newTask)
        openTasksIDs.append(newTask.taskRef.key)
        
        let openTaskRef = listRef.child(FirebaseKeys.openTasks)
        openTaskRef.setValue(openTasksIDs)
        
        listDelegate.insert(at: openTasksIDs.count-1)
    }
    
    func delete(at index: Int) {
        if index < openTasks.count {
            // open task
            // delete from Task data sources
            let taskDataRef = AppDatabase.taskDataRootRef.child(openTasksIDs[index])
            taskDataRef.removeValue()
            openTasks.remove(at: index)
            
            //delete taskID from lists
            openTasksIDs.remove(at: index)
            let tasksListRef = listRef.child(FirebaseKeys.openTasks)
            tasksListRef.setValue(openTasksIDs)
            
        } else {
            // closed task
            let closedIndex = index - openTasks.count
            let taskDataRef = AppDatabase.taskDataRootRef.child(closedTasksIDs[closedIndex])
            taskDataRef.removeValue()
            closedTasks.remove(at: closedIndex)
            
            //delete taskID from lists
            closedTasksIDs.remove(at: closedIndex)
            let tasksListRef = listRef.child(FirebaseKeys.closedTasks)
            tasksListRef.setValue(closedTasksIDs)
        }
        listDelegate.delete(at: index)
    }
    
    func completeTask(at taskIndex: Int) {
        if taskIndex >= openTasks.count {
            fatalError("out of bounds on 'openTasks'")
        }
        
        // get the indexed task
        let completedTask = openTasks[taskIndex]
        
        completedTask.status = true // This will write itself to firebase
        
        // update local lists and view controller delegate
        closedTasks.insert(completedTask, at: 0)
        closedTasksIDs.insert(completedTask.taskRef.key, at: 0)
        if _showCompleted {
            listDelegate.insert(at: openTasksIDs.count) // count is already 1 smaller
        }
        
        openTasks.remove(at: taskIndex)
        openTasksIDs.remove(at: taskIndex)
        listDelegate.delete(at: taskIndex)
        
        listDelegate.updateAll()
        
        // update firebase lists
        let openListRef = listRef.child(FirebaseKeys.openTasks)
        openListRef.setValue(openTasksIDs)
        let closedListRef = listRef.child(FirebaseKeys.closedTasks)
        closedListRef.setValue(closedTasksIDs)
        
        
    }
    
    // taskIndex is a relative index to the openTask List. Not an index into the tableivew
    func reOpenTask(at taskIndex: Int) {
        if taskIndex >= closedTasks.count {
            fatalError("out of bounds on 'closedTasks'")
        }
        
        // get teh indexed path
        let reopenedTask = closedTasks[taskIndex]
        
        // update status to false. This will update firebase by itself
        reopenedTask.status = false
        
        // update local lists and view controller delegate
        openTasks.append(reopenedTask)
        openTasksIDs.append(reopenedTask.taskRef.key)
        listDelegate.insert(at: openTasksIDs.count)
        
        closedTasks.remove(at: taskIndex)
        closedTasksIDs.remove(at: taskIndex)
        if _showCompleted {
            listDelegate.delete(at: openTasksIDs.count + taskIndex)
        }
        
        listDelegate.updateAll()
        
        // update firebase lists
        let openListRef = listRef.child(FirebaseKeys.openTasks)
        openListRef.setValue(openTasksIDs)
        let closedListRef = listRef.child(FirebaseKeys.closedTasks)
        closedListRef.setValue(closedTasksIDs)
    }
    
    func toAnyObject() -> Any {
        return [
            FirebaseKeys.name : name,
            FirebaseKeys.openTasks : openTasksIDs,
            FirebaseKeys.closedTasks : openTasksIDs,
            FirebaseKeys.description : description,
            FirebaseKeys.showCompleted : _showCompleted,
        ]
    }
    
}
