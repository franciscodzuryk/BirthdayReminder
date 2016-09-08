//
//  AddBirthdayViewController.swift
//  BirthdayReminder
//
//  Created by Francisco on 7/19/16.
//  Copyright © 2016 Francisco. All rights reserved.
//

import UIKit

protocol AddBirthdayDelegate {
    func birthdayDidAdd(birthday: Birthday) -> Void
    func birthdayDidUpdate(birthday: Birthday) -> Void
}

class AddBirthdayViewController: UIViewController {
    @IBOutlet weak var daysBeforeLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var daysBeforeSlider: UISlider!
    
    
    var delegate: AddBirthdayDelegate?
    var birthday: Birthday!
    var isUpdating = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
    
        if birthday == nil {
            birthday = Birthday()
            isUpdating = false;
        }
        
        titleTextField.text = birthday.title
        birthdayDatePicker.date = birthday.date
        daysBeforeSlider.value = birthday.daysBefore.floatValue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func daysBeforeChanged(sender: UISlider) {
        let days = NSNumber(float: round(sender.value))
        daysBeforeLabel.text = "Notify \(days.intValue) days before"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        saveBirthday()
    }
    
    func saveBirthday() {
        birthday.title = titleTextField.text!
        birthday.date = birthdayDatePicker.date
        birthday.daysBefore = NSNumber(float: round(daysBeforeSlider.value))
        
        if isUpdating {
            delegate?.birthdayDidUpdate(birthday)
        } else {
            delegate?.birthdayDidAdd(birthday)
        }        
    }
}