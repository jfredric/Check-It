//
//  AppData.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 9/27/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import Foundation
import Firebase

class AppData {
    
    // MARK: PROPERTIES
    var toDoLists: [ToDoList] = []
    private var toDoListsIDs: [String] = []
    var currentUser: User?
    var userDataRef: DatabaseReference?
    
    // Controller delegate
    var listDelegate: ListDataViewDelegate!
    
    // MARK: CONSTANTS
    
    
    // Singleton
    static let sharedInstance = AppData()
    
    private init() {
        
    }
    
    func configureFor(user: User?) {
        currentUser = user
        if currentUser != nil {
            // fetches database reference for user list data, creates it if not found.
            userDataRef = AppDatabase.userDataRootRef.child(currentUser!.uid)
        } else {
            toDoLists = []
            toDoListsIDs = []
            userDataRef = nil
        }
    }
    
    func add(newList: ToDoList) {
        if currentUser != nil {
            toDoLists.append(newList)
            toDoListsIDs.append(newList.listRef.key)
            userDataRef!.setValue(toDoListsIDs)
            // tell view controller to update view
            listDelegate.insert(at: toDoLists.count-1)
        }
    }
    
    func delete(at index: Int) {
        toDoLists.remove(at: index)
        listDelegate.delete(at: index)
    }
    

    // do not use at this point
    func addSampleData() {
        let groceryList = ToDoList(name: "Groceries", description: "")
        groceryList.openTasks.append(Task(title: "Milk", description: "", status: false))
        groceryList.openTasks.append(Task(title: "eggs", description: "", status: false))
        groceryList.openTasks.append(Task(title: "cheese", description: "", status: false))
        groceryList.openTasks.append(Task(title: "bread", description: "", status: false))
        groceryList.openTasks.append(Task(title: "beer", description: "", status: false))
        toDoLists.append(groceryList)
        
        let choresList = ToDoList(name: "Chores", description: "")
        choresList.openTasks.append(Task(title: "Dishes", description: "", status: false))
        choresList.openTasks.append(Task(title: "Sweep", description: "", status: false))
        choresList.openTasks.append(Task(title: "clean toilets", description: "", status: false))
        choresList.closedTasks.append(Task(title: "Wash Car", description: "", status: true))
        choresList.closedTasks.append(Task(title: "Mow Lawn", description: "", status: true))
        toDoLists.append(choresList)
        
        let projectsList = ToDoList(name: "Projects", description: "")
        projectsList.openTasks.append(Task(title: "Project 1", description: "", status: false))
        projectsList.openTasks.append(Task(title: "Some App", description: "", status: false))
        projectsList.openTasks.append(Task(title: "storage workbench", description: "", status: false))
        projectsList.closedTasks.append(Task(title: "Build Desk ", description: "", status: true))
        projectsList.closedTasks.append(Task(title: "Week 2 Lab", description: "", status: true))
        toDoLists.append(projectsList)
    }
}
