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
    var title: String
    var description: String
    var _status: Bool
    var status: Bool {
        get {
            return _status
        }
        set {
            _status = newValue
            taskRef.child(FirebaseKeys.status).setValue(status)
        }
        
    }
    var taskRef: DatabaseReference
    
    struct FirebaseKeys {
        static let title = "title"
        static let description = "description"
        static let status = "status"
    }
    
    init(title newTitle: String, description newDesc: String, status newStatus: Bool) {
        title = newTitle
        description = newDesc
        _status = newStatus
        taskRef = AppDatabase.taskDataRootRef.childByAutoId()
        taskRef.setValue(toAnyObject())
    }
    
    init(from snapshot: DataSnapshot) {
        taskRef = snapshot.ref
        let newTaskData = snapshot.value as! [String:Any]
        title = newTaskData[FirebaseKeys.title] as! String
        if let newDescription = newTaskData[FirebaseKeys.description] {
            description = newDescription as! String
        } else {
            description = ""
        }
        _status = newTaskData[FirebaseKeys.status] as! Bool
    }
    
    
    func toAnyObject() -> Any {
        return [
            FirebaseKeys.title: title,
            FirebaseKeys.description: description,
            FirebaseKeys.status : _status
        ]
    }
}
