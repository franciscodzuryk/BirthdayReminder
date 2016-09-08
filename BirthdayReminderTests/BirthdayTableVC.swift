//
//  BirthdayTableVC.swift
//  BirthdayReminder
//
//  Created by Carlos David Rios Vertel on 9/6/16.
//  Copyright © 2016 Francisco. All rights reserved.
//

import XCTest
@testable import BirthdayReminder


class BirthdayTableVC: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testRefreshingDataOnViewDidLoad() {
        //Given
        class MockTablewViewVC: BirthdayTableViewController {
            
            var refreshDataCalled = false
            override func refreshData() {
                refreshDataCalled = true
            }
        }
        
        let mock = MockTablewViewVC()
        
        //When
        mock.viewDidLoad()
        
        //Then
        XCTAssert(mock.refreshDataCalled, "Refresh data isn't been called on viewDidLoad")
        
    }
    
    func testDidAddBirthday() {
        //Given
        class MockTablewViewVC: BirthdayTableViewController {
            
            var refreshDataCalled = false
            override func refreshData() {
                refreshDataCalled = true
            }
        }
        
        class MockManager: BirthdayManagerProtocol {
            
            var addObjectCalled = false
            
            func add(birthday: Birthday) -> Void {
                addObjectCalled = true
            }
            func delete(birthday: Birthday) -> Void {}
            func update(birthday: Birthday) -> Void {}
            func list() -> [Birthday] { return []}
        }
        
        class MockNotificator: BirthdayNotficatorProtocol {
            
            var scheduleNotificationCalled = false
            func scheduleBirthday(birthday: Birthday) -> UILocalNotification {
                scheduleNotificationCalled = true
                return UILocalNotification()
            }
            
            func reScheduleBirthday(birthday: Birthday) -> UILocalNotification?{ return nil}
           
        }
        
        let mock = MockTablewViewVC()
        let mockManager = MockManager()
        let mockNotficator = MockNotificator()

        mock.manager = mockManager
        mock.notificator = mockNotficator
        let birthday = Birthday()
        
        
        //When
        mock.birthdayDidAdd(birthday)
        
        //Then 
        XCTAssert(mockManager.addObjectCalled, "The object isn't been saved in the manager")
        XCTAssert(mockNotficator.scheduleNotificationCalled, "The birthday isn't been scheduled")
        XCTAssert(mock.refreshDataCalled, "Isn't refreshing the data after saved object")
    }
    
    func testDidUpdateBirthday() {

        class MockTablewViewVC: BirthdayTableViewController {
            
            var refreshDataCalled = false
            override func refreshData() {
                refreshDataCalled = true
            }
        }
        
        class MockManager: BirthdayManagerProtocol {
            
            var updateCalled = false
            
            func add(birthday: Birthday) -> Void { }
            func delete(birthday: Birthday) -> Void {}
            func update(birthday: Birthday) -> Void {
                updateCalled = true
            }
            
            func list() -> [Birthday] { return []}
        }
        
        class MockNotificator: BirthdayNotficatorProtocol {
            
            var re_scheduleNotificationCalled = false
            func scheduleBirthday(birthday: Birthday) -> UILocalNotification {
                return UILocalNotification()
            }
            
            func reScheduleBirthday(birthday: Birthday) -> UILocalNotification?{
                re_scheduleNotificationCalled = true
                return nil
            }
            
        }
        
        
        
        let mock = MockTablewViewVC()
        
        
        let mockManager = MockManager()
        let mockNotficator = MockNotificator()
        
        mock.manager = mockManager
        mock.notificator = mockNotficator
        let birthday = Birthday()
        
        //When
        mock.birthdayDidUpdate(birthday)
        
        //Then
        XCTAssert(mockManager.updateCalled, "Manager update birthday wasn't called")
        XCTAssert(mockNotficator.re_scheduleNotificationCalled, "re-schedule notification isn't been called")
        XCTAssert(mock.refreshDataCalled, "Isn't refreshing the data after saved object")
        
    }
    
    func testResfreshData() {
        //Given
        class MockManager: BirthdayManagerProtocol {
            
            var updateCalled = false
            
            func add(birthday: Birthday) -> Void {}
            func delete(birthday: Birthday) -> Void {}
            func update(birthday: Birthday) -> Void {}
            
            func list() -> [Birthday] {
                
                let obj1 = Birthday()
                obj1.title = "Carlos"

                let obj2 = Birthday()
                obj2.title = "Andres"
                
                
                return[obj1, obj2]
            }
        }
        
        let mockManager = MockManager()
        let vc = BirthdayTableViewController()
        vc.manager = mockManager
        
        //When
        vc.refreshData()
        
        //Then
        XCTAssert(vc.items?.count == 2, "Inconsistent number of elements. Getting \(vc.items?.count)")
        XCTAssert(vc.items?[0].title == "Andres", "Elements isn't been sorting by title")
        
    }
    
}
