//
//  TasksTableViewCell.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 9/27/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxButon: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func checkBoxSelected(_ sender: UIButton) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
