//
//  AddBirthdayViewController.swift
//  BirthdayReminder
//
//  Created by Francisco on 7/19/16.
//  Copyright © 2016 Francisco. All rights reserved.
//

import UIKit

class AddBirthdayViewController: UIViewController {
    @IBOutlet weak var daysBeforeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        daysBeforeLabel.text = "Notify 1 days before"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func daysBeforeChanged(sender: UISlider) {
        let days = NSNumber(float: round(sender.value))
        daysBeforeLabel.text = "Notify \(days.intValue) days before"
    }
}