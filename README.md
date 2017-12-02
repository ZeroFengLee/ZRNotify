# ZRNotify
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/Then.svg)](https://cocoapods.org/pods/ZRNotify)
	使用一种简洁的方式组织通知的代码逻辑

## pod方式安装

`pod 'ZRNotify', '~> 0.0.5'`

## 使用

> 分开监测

```swift
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
```

> 统一处理监测结果

```swift
lazy var zrNotifys: ZRNotify = {
    var zrnotify = ZRNotify()
    zrnotify.ons(["Schedule1", "Schedule2", "Schedule3"], notify: { notify in
        
        print(notify.object ?? "nil object")
    })
    
    return zrnotify
}()
```

> 初始化通知接收

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    // 初始化
    zrNotify.opStatusForAll(true)
    zrNotifys.opStatusForAll(true)
    
    // 测试
    NotificationCenter.default.post(name: Notification.Name(rawValue: "ScheduleA"), object: "hello ScheduleA")
    NotificationCenter.default.post(name: Notification.Name(rawValue: "ScheduleB"), object: nil)
    NotificationCenter.default.post(name: Notification.Name(rawValue: "ScheduleC"), object: "hello ScheduleC")
    
    // 测试
    NotificationCenter.default.post(name: Notification.Name(rawValue: "Schedule1"), object: "hello Schedule1")
    NotificationCenter.default.post(name: Notification.Name(rawValue: "Schedule2"), object: nil)
    NotificationCenter.default.post(name: Notification.Name(rawValue: "Schedule3"), object: "hello Schedule3")
}
```
