//
//  ViewController.swift
//  ZRNotifyDemo
//
//  Created by Zero on 2017/5/10.
//  Copyright © 2017年 Zero. All rights reserved.
//

import UIKit
import ZRNotify

class ViewController: UIViewController {

    /*
        1.
     */
    lazy var zrNotify: ZRNotify = {
        var zrnotify = ZRNotify()
        zrnotify.on("ScheduleA", notify: { notify in
            
            print(notify.object ?? "nil object")
        }).on("ScheduleB", notify: { notify in
            
            print(notify.object ?? "nil object")
        }).on("ScheduleC", notify: { notify in
            
            print(notify.object ?? "nil object")
        })
        
        return zrnotify
    }()
    
    /*
        2.
     */
    lazy var zrNotifys: ZRNotify = {
        var zrnotify = ZRNotify()
        zrnotify.ons(["Schedule1", "Schedule2", "Schedule3"], notify: { notify in
            
            print(notify.object ?? "nil object")
        })
        
        return zrnotify
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zrNotify.opStatusForAll(true)
        zrNotifys.opStatusForAll(true)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ScheduleA"), object: "hello ScheduleA")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ScheduleB"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ScheduleC"), object: "hello ScheduleC")
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Schedule1"), object: "hello Schedule1")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Schedule2"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Schedule3"), object: "hello Schedule3")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

