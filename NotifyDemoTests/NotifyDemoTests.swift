//
//  NotifyDemoTests.swift
//  NotifyDemoTests
//
//  Created by 李锋 on 2017/12/5.
//  Copyright © 2017年 Zero. All rights reserved.
//

import XCTest
@testable import NotifyDemo

class NotifyDemoTests: XCTestCase {
    
    var notifyer: ZRNotify!
    override func setUp() {
        super.setUp()
        
        notifyer = ZRNotify()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNormal() {
        
        notifyer.on("NotifyerName") { notifyer in
            XCTAssertNotNil(notifyer.object, "notifyer.object is nill")
        }
        
        notifyer.on("NotifyerName", notify: { notify in
            XCTAssertEqual("notify.value", notify.object as! String, "normal not equal")
        })
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "NotifyerName"), object: "notify.value")
    }
    
    func testChain() {
        
        notifyer.on("Chain.ScheduleA") { notify in
            XCTAssertNotNil(notify.object, "Chain.ScheduleA.object is nill")
            XCTAssertEqual("Chain.ScheduleA.value", notify.object as! String, "Chain.ScheduleA not equal")
        }.on("Chain.ScheduleB") { notify in
            XCTAssertNotNil(notify.object, "Chain.ScheduleB.object is nill")
            XCTAssertEqual("Chain.ScheduleB.value", notify.object as! String, "Chain.ScheduleB not equal")
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Chain.ScheduleA"), object: "Chain.ScheduleA.value")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Chain.ScheduleB"), object: "Chain.ScheduleB.value")
    }
    
    func testUnify() {
        
        notifyer.ons(["Unify.Schedule1", "Unify.Schedule2"]) { notify in
            XCTAssertNotNil(notify.object, "Unify notification is nill")
            XCTAssert( notify.object as! String == "Unify.Schedule1.value" || notify.object as! String == "Unify.Schedule2.value", "Unify's object is not equal")
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Unify.Schedule1"), object: "Unify.Schedule1.value")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Unify.Schedule2"), object: "Unify.Schedule2.value")
    }
}



