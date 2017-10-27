//
//  ToDoList.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 10/27/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import Foundation

class ToDoList {
    var name: String = "Name"
    var openTasks: [Task] = []
    var closedTasks: [Task] = []
    var description: String = ""
    var showCompleted: Bool = false
    
    init(name newName: String, description newDesc: String) {
        name = newName
        description = newDesc
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
    
}
