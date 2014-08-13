//
//  OptionsViewController.swift
//  MATextFieldCell Example
//
//  Created by Mike on 6/14/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

import UIKit

class OptionsViewController: UITableViewController {
    let swiftOptions = ["Short Form Example", "Numeric Example", "Full Example"]
    let objCOptions = ["Objective-C Full Example"]

    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init() {
        super.init(style: .Grouped)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Examples"
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return section == 0 ? "Swift Examples" : "Objective-C Examples"
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? swiftOptions.count : objCOptions.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell

        cell.textLabel.text = indexPath.section == 0 ? swiftOptions[indexPath.row] : objCOptions[indexPath.row]

        return cell
    }
    
    // #pragma mark - Table view delegate
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.section == 0) {
            if indexPath.row == 0 {
                let shortFormVC: ShortFormExampleTableViewController = ShortFormExampleTableViewController(style: .Grouped)
                self.navigationController.pushViewController(shortFormVC, animated: true)
            }
            else if indexPath.row == 1 {
                let numericFormVC: NumericFormExampleTableViewController = NumericFormExampleTableViewController(style: .Grouped)
                self.navigationController.pushViewController(numericFormVC, animated: true)
            }
            else {
                let fullFormVC: ExampleFormTableViewController = ExampleFormTableViewController(style: .Grouped)
                self.navigationController.pushViewController(fullFormVC, animated: true)
            }
        }
        else {
            let objCFormVC: ExampleObjCFormTableViewController = ExampleObjCFormTableViewController()
            self.navigationController.pushViewController(objCFormVC, animated: true)
        }
    }

}
