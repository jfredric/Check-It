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
            // set listener for changes including initial load
            userDataRef?.observe(.childAdded, with: { (snapshot) in
                let newListID = snapshot.key
                let name = snapshot.value ?? ""
                print("observe new child(user-data)",newListID,"-",name)
                // new login, loading first list or new add
                AppDatabase.listDataRootRef.child(newListID).observe(.value, with: { (listSnapshot) in
                    self.toDoListsIDs.append(newListID)
                    let newList = ToDoList(from: listSnapshot) // download list data
                    self.toDoLists.append(newList)
                    // tell view controller to update view
                    self.listDelegate.insert(at: self.toDoLists.count - 1)
                })
            })
            userDataRef?.observe(.childRemoved, with: { (snapshot) in
                let key = snapshot.key
                let name = snapshot.value ?? ""
                print("observe removed child:",key,"-",name)
                if let index = self.toDoListsIDs.index(of: key) {
                    self.toDoLists.remove(at: index)
                    self.listDelegate.delete(at: index)
                }
            })
        } else {
            toDoLists = []
            toDoListsIDs = []
            userDataRef = nil
        }
    }
    
    func add(newList: ToDoList) {
        if currentUser != nil {
            let newListRef = userDataRef!.child(newList.listRef.key)
            newListRef.setValue(newList.name)
        }
    }
    
    func delete(at index: Int) {
        if currentUser != nil {
            AppDatabase.listDataRootRef.child(toDoListsIDs[index]).removeValue()
            userDataRef?.child(toDoListsIDs[index]).removeValue()
        }
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
