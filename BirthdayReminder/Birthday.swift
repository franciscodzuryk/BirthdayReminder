//
//  Birthday.swift
//  BirthdayReminder
//
//  Created by Francisco on 7/20/16.
//  Copyright © 2016 Francisco. All rights reserved.
//

import Foundation

class Birthday {
    var title = ""
    var date = NSDate()
    var daysBefore = NSNumber(int: 1)
    
    init() {
        
    }
    
    init (data: NSDictionary) {
        title = data["title"] as! String
        date = data["date"] as! NSDate
        daysBefore = data["daysBefore"] as! NSNumber
    }
    
    func isValid() -> Bool {
        return !title.isEmpty
    }
}