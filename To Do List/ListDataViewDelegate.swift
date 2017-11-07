//
//  ListDataViewDelegate.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 10/28/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import Foundation

protocol ListDataViewDelegate {
    
    func insert(at: Int)
    func delete(at: Int)
    func change(at: Int)
    func updateAll()
    
}
