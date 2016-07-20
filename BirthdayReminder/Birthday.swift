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
    var daysBefore = 1
    
    func isValid() -> Bool {
        return !title.isEmpty
    }
}