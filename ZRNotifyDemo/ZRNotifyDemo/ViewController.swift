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

    lazy var zrNotify: ZRNotify = {
        var zrnotify = ZRNotify()
        zrnotify.on("ScheduleA", notify: { notify in
            
        }).on("ScheduleB", notify: { notify in
            
        }).on("ScheduleC", notify: { notify in
            
        })
        
        return zrnotify
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

