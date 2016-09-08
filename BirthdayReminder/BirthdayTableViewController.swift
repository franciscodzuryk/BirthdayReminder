//
//  ViewController.swift
//  BirthdayReminder
//
//  Created by Francisco on 7/19/16.
//  Copyright © 2016 Francisco. All rights reserved.
//

import UIKit

class BirthdayTableViewController: UITableViewController, AddBirthdayDelegate {
    let kCellIdentifier = "BirthdayCell"
    var manager: BirthdayManagerProtocol = BirthdayManager()!
    var items: Array<Birthday>?
    var notificator: BirthdayNotficatorProtocol = BirthdayNotficator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let addVC = segue.destinationViewController as! AddBirthdayViewController
        addVC.delegate = self
        
        if segue.identifier == "updateBirthdayIdentifier" {
            let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell);
            addVC.birthday = items![(indexPath?.row)!]
        }
    }
    
    func birthdayDidAdd(birthday: Birthday) -> Void {
        manager.add(birthday)
        notificator.scheduleBirthday(birthday)
        refreshData()
    }
    
    func refreshData(){
        items = manager.list().sort({ (a, b) -> Bool in
            a.title < b.title
        })
        tableView.reloadData()
    }
    
    func birthdayDidUpdate(birthday: Birthday) -> Void {
        manager.update(birthday)
        notificator.reScheduleBirthday(birthday)
        refreshData()
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
        return items!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! BirthdayCell
        cell.configure(items![indexPath.row])
        return cell
    }
    
    // MARK: Editing Delegate
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            manager.delete(items![indexPath.row])
            items?.removeAtIndex(indexPath.row)
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
