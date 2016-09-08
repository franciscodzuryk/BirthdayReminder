//
//  BirthdayManagerTests.swift
//  BirthdayReminder
//
//  Created by Carlos David Rios Vertel on 9/6/16.
//  Copyright © 2016 Francisco. All rights reserved.
//

import XCTest
@testable import BirthdayReminder


class MockMutableDictionary: NSMutableDictionary {
    var setObjectCalled = false
    var writeToFileCalled = false
    var removeObjectCalled = false
    
    override internal func setObject(anObject: AnyObject, forKey aKey: NSCopying) {
        setObjectCalled = true
    }
    
    override internal func writeToFile(path: String, atomically useAuxiliaryFile: Bool) -> Bool {
        writeToFileCalled = true
        return true
    }
    
    override func removeObjectForKey(aKey: AnyObject) {
        removeObjectCalled = true
    }
}


class BirthdayManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSavingBirthday() {
        
        //Given
        let data = MockMutableDictionary()
        let manager = BirthdayManager()

        manager?.birthdayData = data
        let birthday = Birthday()

        //When
        manager?.add(birthday)
        
        //Then
        XCTAssert(data.setObjectCalled, "Set object wasn't called")
        XCTAssert(data.writeToFileCalled, "write to file wasn't called")
    }
    
    func testUpdatingBirthday() {
        
        //Given
        let data = MockMutableDictionary()
        let manager = BirthdayManager()
        
        manager?.birthdayData = data
        let birthday = Birthday()
        
        //When
        manager?.update(birthday)
        
        //Then
        XCTAssert(data.setObjectCalled, "Set object wasn't called")
        XCTAssert(data.writeToFileCalled, "write to file wasn't called")
    }

    func testRemoveBirthday() {
        
        //Given
        let data = MockMutableDictionary()
        let manager = BirthdayManager()
        
        manager?.birthdayData = data
        let birthday = Birthday()
        
        //When
        manager?.delete(birthday)
        
        //Then
        XCTAssert(data.removeObjectCalled, "Set object wasn't called")
        XCTAssert(data.writeToFileCalled, "write to file wasn't called")
    }
    
    
    
}
