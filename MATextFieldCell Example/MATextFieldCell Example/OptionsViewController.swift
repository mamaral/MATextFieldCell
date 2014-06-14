//
//  OptionsViewController.swift
//  MATextFieldCell Example
//
//  Created by Mike on 6/14/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

import UIKit

class OptionsViewController: UITableViewController {
    let options = ["Short Form Example", "Numeric Example", "Full Example"]

    init() {
        super.init(style: .Plain)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Examples"
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell

        cell.textLabel.text = options[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
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

}
