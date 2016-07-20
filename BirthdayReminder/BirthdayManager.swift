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
    func list(predicate: NSPredicate) -> Array<Birthday>
}

class BirthdayManager: BirthdayManagerProtocol {
    func add(birthday: Birthday) {
        print("Add")
    }
    
    func delete(birthday: Birthday) {
        print("Delete")
    }
    
    func update(birthday: Birthday) {
        print("Update")
    }
    
    func list(predicate: NSPredicate) -> Array<Birthday> {
        print("List")
        return [Birthday()]
    }
}