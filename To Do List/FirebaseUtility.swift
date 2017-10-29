//
//  FirebaseUtility.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 10/28/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import Foundation
import Firebase

class AppDatabase {
    static let userDataRootRef = Database.database().reference(withPath: "user-data")
    static let listDataRootRef = Database.database().reference(withPath: "list-data")
    static let taskDataRootRef = Database.database().reference(withPath: "task-data")
}

