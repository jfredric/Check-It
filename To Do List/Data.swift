//
//  Data.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 9/27/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import Foundation

class Data {
    
    static var toDoLists: [ToDoList] = []
}

func addSampleData() {
    let groceryList = ToDoList(name: "Groceries", description: "")
    groceryList.openTasks.append(Task(title: "Milk", description: "", status: false))
    groceryList.openTasks.append(Task(title: "eggs", description: "", status: false))
    groceryList.openTasks.append(Task(title: "cheese", description: "", status: false))
    groceryList.openTasks.append(Task(title: "bread", description: "", status: false))
    groceryList.openTasks.append(Task(title: "beer", description: "", status: false))
    Data.toDoLists.append(groceryList)
    
    let choresList = ToDoList(name: "Chores", description: "")
    choresList.openTasks.append(Task(title: "Dishes", description: "", status: false))
    choresList.openTasks.append(Task(title: "Sweep", description: "", status: false))
    choresList.openTasks.append(Task(title: "clean toilets", description: "", status: false))
    choresList.closedTasks.append(Task(title: "Wash Car", description: "", status: true))
    choresList.closedTasks.append(Task(title: "Mow Lawn", description: "", status: true))
    Data.toDoLists.append(choresList)
    
    let projectsList = ToDoList(name: "Projects", description: "")
    projectsList.openTasks.append(Task(title: "Project 1", description: "", status: false))
    projectsList.openTasks.append(Task(title: "Some App", description: "", status: false))
    projectsList.openTasks.append(Task(title: "storage workbench", description: "", status: false))
    projectsList.closedTasks.append(Task(title: "Build Desk ", description: "", status: true))
    projectsList.closedTasks.append(Task(title: "Week 2 Lab", description: "", status: true))
    Data.toDoLists.append(projectsList)
}
