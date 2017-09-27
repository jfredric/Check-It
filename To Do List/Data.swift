//
//  Data.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 9/27/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import Foundation

class Task {
    var title: String = "title"
    var description: String = ""
    var status: Bool = false
    
    init(title newTitle: String, description newDesc: String, status newStatus: Bool) {
        title = newTitle
        description = newDesc
        status = newStatus
    }
}

class ToDoList {
    var name: String = "Name"
    var openTasks: [Task] = []
    var closedTasks: [Task] = []
    var description: String = ""
    
    init(name newName: String, description newDesc: String) {
        name = newName
        description = newDesc
    }
    
    func completeTask(at taskIndex: Int) {
        if taskIndex >= openTasks.count {
            fatalError("out of bounds on 'openTasks'")
        }
        var completedTask = openTasks[taskIndex]
        completedTask.status = true
        closedTasks.insert(completedTask, at: 0)
        openTasks.remove(at: taskIndex)
    }
    
    func reOpenTask(at taskIndex: Int) {
        if taskIndex >= closedTasks.count {
            fatalError("out of bounds on 'closedTasks'")
        }
        var completedTask = openTasks[taskIndex]
        completedTask.status = false
        openTasks.append(completedTask)
        closedTasks.remove(at: taskIndex)
    }
    
}

class Data {
    
    static var toDoLists: [ToDoList] = []
    
}
