//
//  Birthday.swift
//  BirthdayReminder
//
//  Created by Francisco on 7/20/16.
//  Copyright © 2016 Francisco. All rights reserved.
//

import Foundation

class Birthday {
    var identifier = ""
    var title = ""
    var date = NSDate()
    var daysBefore = NSNumber(int: 1)
    
    init() {
        
    }
    
    init (key: String, data: NSDictionary) {
        identifier = key
        title = data["title"] as! String
        date = data["date"] as! NSDate
        daysBefore = data["daysBefore"] as! NSNumber
    }
    
    func getDictionary() -> NSDictionary {
        return NSDictionary(objects: [title, date, daysBefore], forKeys: ["title", "date", "daysBefore"])
    }
    
    func isValid() -> Bool {
        return !title.isEmpty
    }
}