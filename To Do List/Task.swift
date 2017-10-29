//
//  Task.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 10/27/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import Foundation
import Firebase

class Task {
    var title: String = "title"
    var description: String = ""
    var status: Bool = false
    var taskRef: DatabaseReference
    
    struct FirebaseKeys {
        static let title = "title"
        static let description = "description"
        static let status = "status"
    }
    
    init(title newTitle: String, description newDesc: String, status newStatus: Bool) {
        title = newTitle
        description = newDesc
        status = newStatus
        taskRef = AppDatabase.taskDataRootRef.childByAutoId()
        taskRef.setValue(toAnyObject())
    }
    
    func toAnyObject() -> Any {
        return [
            FirebaseKeys.title: title,
            FirebaseKeys.description: description,
            FirebaseKeys.status : status
        ]
    }
}
