//
//  AddBirthdayVCTests.swift
//  BirthdayReminder
//
//  Created by Carlos David Rios Vertel on 9/6/16.
//  Copyright © 2016 Francisco. All rights reserved.
//

import XCTest
@testable import BirthdayReminder

class AddBirthdayVCTests: XCTestCase {
    
    var vc: AddBirthdayViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()

        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        vc = storyboard.instantiateViewControllerWithIdentifier(String(AddBirthdayViewController)) as! AddBirthdayViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        window = nil
        super.tearDown()
    }
    
    func loadView() {
        window.addSubview(vc.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }
    
    
    func testNilBirthdayShouldCreateNewOneOnViewDidLoad(){
        //Given
        vc.birthday = nil
        
        //When
        loadView()
        
        //Then
        XCTAssert(vc.birthday != nil, "The birthday object shouldn't be nil")
        XCTAssert(vc.isUpdating == false, "The birthday object shouldn't be nil")
        
    }
    
    func testProvidedBirthdayShouldLoadEditingMode(){
        //Given
        let date = NSDate()
        let birthday = Birthday()
        birthday.title = "Test Birthday"
        birthday.date = date
        
        vc.birthday = birthday

        //When
        loadView()
        
        //Then
        XCTAssert(vc.isUpdating == true, "Controller isn't been initialized in editing mode")
        XCTAssert(vc.birthdayDatePicker.date === date, "Controller isn't loading the right date value")
    }
    
    func testCallToDidAddDelegateMethod(){
        //Given
        class MockDelegate: AddBirthdayDelegate {
            
            var didAddCalled = false
            var birthday: Birthday!
            
            func birthdayDidAdd(birthday: Birthday) {
                didAddCalled = true
                self.birthday = birthday
            }
            
            func birthdayDidUpdate(birthday: Birthday) {
            
            }
        }
        
        loadView()
        let mock = MockDelegate()
        vc.delegate = mock
        
        
        //When
        
        vc.saveBirthday()
        
        //Then
        XCTAssert(mock.didAddCalled, "did add delegate method wasn't called")
        XCTAssert(mock.birthday != nil, "birthday object should be nil")
    }
    
    func testCallToDidUpdateDelegateMethod(){
    
        //Given
        let date = NSDate()
        let birthday = Birthday()
        birthday.title = "Test Birthday"
        birthday.date = date

        vc.birthday = birthday
        vc.isUpdating = true
        
        class MockDelegate: AddBirthdayDelegate {
            
            var didUpdateCalled = false
            var birthday: Birthday!
            
            func birthdayDidAdd(birthday: Birthday) {
            }
            
            func birthdayDidUpdate(birthday: Birthday) {
                self.birthday = birthday
                didUpdateCalled = true
            }
        }
        
        loadView()
        let mock = MockDelegate()
        vc.delegate = mock
        
        
        //When
        vc.titleTextField.text = "Modfied title"
        vc.saveBirthday()
        
        //Then
        XCTAssert(mock.didUpdateCalled, "did update delegate method wasn't called")
        XCTAssert(mock.birthday.title == "Modfied title", "Inconsistent title")
    }
    
}
