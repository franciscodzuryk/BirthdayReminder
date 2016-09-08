//
//  BirthdayNotficator.swift
//  BirthdayReminder
//
//  Created by Carlos David Rios Vertel on 9/7/16.
//  Copyright © 2016 Francisco. All rights reserved.
//

import Foundation
import UIKit

protocol BirthdayNotficatorProtocol {
    func scheduleBirthday(birthday: Birthday) -> UILocalNotification
    func reScheduleBirthday(birthday: Birthday) -> UILocalNotification?
}

class  BirthdayNotficator: BirthdayNotficatorProtocol {

    var application = UIApplication.sharedApplication()
    
    func scheduleBirthday(birthday: Birthday) -> UILocalNotification {
        
        let days = Double(birthday.daysBefore)
        let local = UILocalNotification()
        local.fireDate = birthday.date.dateByAddingTimeInterval(-days*24*60*60)
        local.alertBody = birthday.title
        local.alertAction = "OK"
        local.timeZone = NSTimeZone.defaultTimeZone()
        local.userInfo = ["id": birthday.identifier]
        application.scheduleLocalNotification(local)
        
        return local
    }
    
    func reScheduleBirthday(birthday: Birthday) -> UILocalNotification? {
        for noty in application.scheduledLocalNotifications! {
            if let id = noty.userInfo?["id"] as? String where id == birthday.identifier {
                application.cancelLocalNotification(noty)
                return scheduleBirthday(birthday)
            }
            
        }
        
        return nil
    }
}