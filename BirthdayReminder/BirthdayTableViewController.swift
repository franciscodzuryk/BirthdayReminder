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
    let manager = BirthdayManager()!
    //var items = ["item 1", "item 2", "item 3"]
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
    
    // MARK: TableView Delegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }

    // MARK: TableView DataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! BirthdayCell
        cell.configure(manager.list[indexPath.row])
        return cell
    }
    
    // MARK: Editing Delegate
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            manager.delete(manager.list[indexPath.row])
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}

class BirthdayCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daysBeforeLabel: UILabel!
    
    
    func configure(birthday: Birthday) -> Void {
        descriptionLabel.text = birthday.title
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = dateFormatter.stringFromDate(birthday.date)
        daysBeforeLabel.text = "Se notificará \(birthday.daysBefore) días antes del cumpleaños"
    }
}
