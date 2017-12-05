# ZRNotify
![build](https://travis-ci.org/ZeroFengLee/ZRNotify.svg?branch=master)
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
![CocoaPods](http://img.shields.io/cocoapods/v/ZRNotify.svg)
![License](https://img.shields.io/cocoapods/l/ZRNotify.svg)	
![Platform](https://img.shields.io/cocoapods/p/ZRNotify.svg)
	
✨ZRNotify is a new way of dealing with Notification，more simpler and more convenient


## Bad Way

observer notification

```swfit
NotificationCenter.default.addObserver(self, selector: #selector(acceptNotify), name: NSNotification.Name(rawValue: "NotifyName"), object: nil)

func acceptNotify(notify: Notification) {
   print(notify)
}
```

post notification
```swfit
NotificationCenter.default.post(name: Notification.Name(rawValue: "NotifyName"), object: "hello")
```

## ZRNotify Way

```swfit
ZRNotify().on("NotifyName", notify: { notify in  
   print(notify.object)
})
```

post notification
```swfit
NotificationCenter.default.post(name: Notification.Name(rawValue: "NotifyName"), object: "hello")
```
## Advanced Usage

Initialize ZRNotify

```swift
let notify = ZRNotify()
```

start observer
> there are two ways to observer，you can use one of them according to the actual situation

way 01: Separate Observer

```swift
notify.on("ScheduleA", notify: { notify in

    print(notify.object)
}).on("ScheduleB", notify: { notify in

    print(notify.object)
})
```

way 02: Unified Observer

```swift
notify.ons(["ScheduleA", "ScheduleB"], notify: { notify in
        
    print(notify.object)
})
```

post notification

```swfit
NotificationCenter.default.post(name: Notification.Name(rawValue: "ScheduleA"), object: "hello A")
NotificationCenter.default.post(name: Notification.Name(rawValue: "ScheduleB"), object: "hello B")
```

## Installation

`pod 'ZRNotify', '~> 0.0.5'`

## License

**ZRNotify** is under MIT license. See the [LICENSE](LICENSE) file for more info.
