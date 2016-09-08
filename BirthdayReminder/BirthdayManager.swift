//
//  BirthdayManager.swift
//  BirthdayReminder
//
//  Created by Francisco on 7/20/16.
//  Copyright © 2016 Francisco. All rights reserved.
//

import Foundation

protocol BirthdayManagerProtocol {
    func add(birthday: Birthday) -> Void
    func delete(birthday: Birthday) -> Void
    func update(birthday: Birthday) -> Void
    func list() -> [Birthday]
}

class BirthdayManager: BirthdayManagerProtocol {
    var birthdayData : NSMutableDictionary
    let filePath: String
    
    convenience init?() {
        guard let path = NSBundle.mainBundle().pathForResource("BirthdayData", ofType: "plist") else { return nil }
        guard let data = NSMutableDictionary(contentsOfFile: path) else { return nil }
        self.init(data: data, path: path)
    }
    
    init(data: NSMutableDictionary, path: String) {
        filePath = path
        birthdayData = data
    }
    
    func add(birthday: Birthday) {
        print("Add")
        birthdayData.setObject(birthday.getDictionary(), forKey: birthday.identifier)
        birthdayData.writeToFile(filePath, atomically: false)
    }
    
    func delete(birthday: Birthday) {
        print("Delete")
        birthdayData.removeObjectForKey(birthday.identifier)
        birthdayData.writeToFile(filePath, atomically: false)
    }
    
    func update(birthday: Birthday) {
        print("Update")
        birthdayData.setObject(birthday.getDictionary(), forKey: birthday.identifier)
        birthdayData.writeToFile(filePath, atomically: false)
    }
    
    func list() -> [Birthday] {
        let arr = birthdayData.map { (key, value) in
            return Birthday(key: key as! String, data: value as! NSDictionary)
        }
        
        return arr
    }
}