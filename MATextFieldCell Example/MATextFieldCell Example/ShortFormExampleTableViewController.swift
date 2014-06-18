//
//  ShortFormExampleTableViewController.swift
//  MATextFieldCell Example
//
//  Created by Mike on 6/14/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

import UIKit

class ShortFormExampleTableViewController: UITableViewController {
    let firstNameCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Name, action: MATextFieldActionType.Next)
    let lastNameCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Name, action: MATextFieldActionType.Next)
    let phoneCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Phone, action: MATextFieldActionType.Done)
    var cells = []
    
    init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateCells()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        firstNameCell.textField.becomeFirstResponder()
    }
    
    func generateCells() {
        firstNameCell.textField.placeholder = "First name"
        firstNameCell.actionBlock = {
            self.lastNameCell.textField.becomeFirstResponder()
            return
        }
        
        lastNameCell.textField.placeholder = "Last name"
        lastNameCell.actionBlock = {
            self.phoneCell.textField.becomeFirstResponder()
            return
        }
        
        phoneCell.textField.placeholder = "Phone"
        phoneCell.actionBlock = {
            self.phoneCell.textField.resignFirstResponder()
            return
        }
        
        cells = [firstNameCell, lastNameCell, phoneCell];
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        return cells[indexPath!.row] as MATextFieldCell
    }
    
}
