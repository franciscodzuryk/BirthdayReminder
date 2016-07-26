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
    func list(predicate: ((birthday: Birthday) -> Bool)?) -> Array<Birthday>
}

class BirthdayManager: BirthdayManagerProtocol {
    var list: Array<Birthday> { get { return list(nil)} }
    let birthdayData : NSMutableDictionary
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
    }
    
    func delete(birthday: Birthday) {
        print("Delete")
    }
    
    func update(birthday: Birthday) {
        print("Update")
    }
    
    func list(predicate: ((birthday: Birthday) -> Bool)?) -> Array<Birthday> {
        let arr = birthdayData.map { (key, value) in
            return Birthday(data: value as! NSDictionary)
        }
        
        if predicate != nil {
            return arr.filter(predicate!)
        }
        return arr
    }
}