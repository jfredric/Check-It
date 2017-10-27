//
//  Task.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 10/27/17.
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
