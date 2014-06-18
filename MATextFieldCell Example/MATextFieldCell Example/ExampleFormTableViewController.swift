//
//  ExampleFormTableViewController.swift
//  MATextfieldCell
//
//  Created by Mike on 6/13/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

import UIKit

class ExampleFormTableViewController: UITableViewController {
    let firstNameCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Name, action: MATextFieldActionType.Next)
    let lastNameCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Name, action: MATextFieldActionType.Next)
    let phoneCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Phone, action: MATextFieldActionType.Next)
    let emailCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Email, action: MATextFieldActionType.Next)
    let urlCell:  MATextFieldCell = MATextFieldCell(type: MATextFieldType.URL, action: MATextFieldActionType.Next)
    let passwordCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Password, action: MATextFieldActionType.Next)
    let streetCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Address, action: MATextFieldActionType.Next)
    let cityCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Default, action: MATextFieldActionType.Next)
    let stateCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.StateAbbr, action: MATextFieldActionType.Next)
    let zipCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.ZIP, action: MATextFieldActionType.Done)
    let blankCell: MATextFieldCell = MATextFieldCell(type: nil, action: nil)
    let nonEditableCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.NonEditable, action: nil)
    var sections: MATextFieldCell[][] = [] // an array of MATextFieldCell arrays
    var firstSectionCells: MATextFieldCell[] = [] // an array of the MATextFieldCells for the first section
    var secondSectionCells: MATextFieldCell[] = []
    var thirdSectionCells: MATextFieldCell[] = []
    
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
        
        // optionally pop up the keyboard immediately
//        firstNameCell.textField.becomeFirstResponder()
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
            self.emailCell.textField.becomeFirstResponder()
            return
        }
        
        emailCell.textField.placeholder = "Email"
        emailCell.actionBlock = {
            self.urlCell.textField.becomeFirstResponder()
            return
        }
        
        urlCell.textField.placeholder = "Website"
        urlCell.actionBlock = {
            self.passwordCell.textField.becomeFirstResponder()
            return
        }
        
        passwordCell.textField.placeholder = "Password"
        passwordCell.actionBlock = {
            self.streetCell.textField.becomeFirstResponder()
            return
        }
        
        streetCell.textField.placeholder = "Street"
        streetCell.actionBlock = {
            self.cityCell.textField.becomeFirstResponder()
            return
        }
        
        cityCell.textField.placeholder = "City"
        cityCell.actionBlock = {
            self.stateCell.textField.becomeFirstResponder()
            return
        }
        
        stateCell.textField.placeholder = "State"
        stateCell.actionBlock = {
            self.zipCell.textField.becomeFirstResponder()
            return
        }
        
        zipCell.textField.placeholder = "ZIP"
        zipCell.actionBlock = {
            self.zipCell.textField.resignFirstResponder()
            return
        }
        
        blankCell.textField.placeholder = "Additional info (optional)"
        nonEditableCell.textField.placeholder = "Non-editable content"
        
        firstSectionCells = [firstNameCell, lastNameCell, phoneCell, emailCell, urlCell, passwordCell]
        secondSectionCells = [streetCell, cityCell, stateCell, zipCell]
        thirdSectionCells = [nonEditableCell, blankCell]
        sections = [firstSectionCells, secondSectionCells, thirdSectionCells]
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return sections.count
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cellsForSection = sections[indexPath!.section]
        return cellsForSection[indexPath!.row]
    }

}
