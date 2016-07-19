//
//  ViewController.swift
//  BirthdayReminder
//
//  Created by Francisco on 7/19/16.
//  Copyright © 2016 Francisco. All rights reserved.
//

import UIKit

class BirthdayTableViewController: UITableViewController {
    let kCellIdentifier = "BirthdayCell"
    var items = ["item 1", "item 2", "item 3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func enterInEditMode(sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.editing, animated: true)
        sender.title = tableView.editing ? "Ok" : "Editing"
    }
    

    // MARK: TableView DataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! BirthdayCell
        return cell
    }
    
    // MARK: Editing Delegate
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}

class BirthdayCell: UITableViewCell {
    
}
