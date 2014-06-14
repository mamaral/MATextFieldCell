//
//  NumericFormExampleTableViewController.swift
//  MATextFieldCell Example
//
//  Created by Mike on 6/14/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

import UIKit

class NumericFormExampleTableViewController: UITableViewController {
    let phoneCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Phone, action: MATextFieldActionType.Next)
    let ZIPCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.ZIP, action: MATextFieldActionType.Next)
    let numberCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Number, action: MATextFieldActionType.Next)
    let decimalCell: MATextFieldCell = MATextFieldCell(type: MATextFieldType.Decimal, action: MATextFieldActionType.Done)
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
        
        phoneCell.textField.becomeFirstResponder()
    }
    
    func generateCells() {
        phoneCell.actionBlock = {
            self.ZIPCell.textField.becomeFirstResponder()
            return
        }
        
        ZIPCell.actionBlock = {
            self.numberCell.textField.becomeFirstResponder()
            return
        }
        
        numberCell.textField.placeholder = "Number"
        numberCell.actionBlock = {
            self.decimalCell.textField.becomeFirstResponder()
            return
        }
        
        decimalCell.textField.placeholder = "Decimal"
        decimalCell.actionBlock = {
            self.decimalCell.textField.resignFirstResponder()
            return
        }
        
        cells = [phoneCell, ZIPCell, numberCell, decimalCell];
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
