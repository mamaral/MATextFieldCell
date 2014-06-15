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
    let passwordCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Password, action: MATextFieldActionType.Next)
    let streetCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Address, action: MATextFieldActionType.Next)
    let cityCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Default, action: MATextFieldActionType.Next)
    let stateCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.StateAbbr, action: MATextFieldActionType.Next)
    let zipCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.ZIP, action: MATextFieldActionType.Done)
    let blankCell: MATextFieldCell = MATextFieldCell(type: nil, action: nil)
    var firstSectionCells = []
    var secondSectionCells = []
    var thirdSectionCells = []
    let sectionCount: Int = 3
    
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
        
        phoneCell.actionBlock = {
            self.emailCell.textField.becomeFirstResponder()
            return
        }
        
        emailCell.actionBlock = {
            self.passwordCell.textField.becomeFirstResponder()
            return
        }
        
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
        
        stateCell.actionBlock = {
            self.zipCell.textField.becomeFirstResponder()
            return
        }
        
        zipCell.actionBlock = {
            self.zipCell.textField.resignFirstResponder()
            return
        }
        
        blankCell.textField.placeholder = "Additional info (optional)"
        
        firstSectionCells = [firstNameCell, lastNameCell, phoneCell, emailCell, passwordCell]
        secondSectionCells = [streetCell, cityCell, stateCell, zipCell]
        thirdSectionCells = [blankCell]
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return sectionCount
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return firstSectionCells.count
        }
        else if section == 1 {
            return secondSectionCells.count
        }
        else if section == 2 {
            return thirdSectionCells.count
        }
        else {
            return 0
        }
    }

    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        if indexPath!.section == 0 {
            return firstSectionCells[indexPath!.row] as MATextFieldCell
        }
        else if indexPath!.section == 1 {
            return secondSectionCells[indexPath!.row] as MATextFieldCell
        }
        else {
            return thirdSectionCells[indexPath!.row] as MATextFieldCell
        }
    }

}
