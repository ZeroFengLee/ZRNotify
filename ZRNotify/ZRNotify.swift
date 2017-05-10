//
//  ZRNotify.swift
//  Planetoid
//
//  Created by Zero on 2017/3/21.
//  Copyright © 2017年 Zero. All rights reserved.
//

import Foundation

public class ZRNotify {
    
    typealias notifierIdentifier = String
    public typealias notifyType = ((Notification) -> Void)

    fileprivate var notifyPool: [(String, notifyType?)] = []
    fileprivate var notifyStatus: [String: Bool] = [:]

    fileprivate lazy var lock: NSLock = {
        var lock = NSLock()
        return lock
    }()

    /*
     one <-> one
     */
    @discardableResult public func on(_ notifyIdentifier: String, notify: notifyType?) -> Self {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotify(_:)), name: NSNotification.Name(rawValue: notifyIdentifier), object: nil)
        lock.lock()
        self.notifyPool.append((notifyIdentifier, notify))
        lock.unlock()
        self.notifyStatus[notifyIdentifier] = true
        return self
    }

    /*
     one <-> many
     */
    @discardableResult public func ons(_ notifyIdentifiers: [String], notify: notifyType?) -> Self {
        lock.lock()
        notifyIdentifiers.forEach {
            NotificationCenter.default.addObserver(self, selector: #selector(receiveNotify(_:)), name: NSNotification.Name(rawValue: $0), object: nil)
            self.notifyPool.append(($0, notify))
            self.notifyStatus[$0] = true
        }
        lock.unlock()
        return self
    }

    /*
     remove notification
     */
    @discardableResult public func remove(_ notifyIdentifier: String) -> Self {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notifyIdentifier), object: nil)
        notifyPool = notifyPool.filter { $0.0 == notifyIdentifier }
        return self
    }

    /*
     remove all notifications
     */
    @discardableResult public func removeAll() -> Self {
        NotificationCenter.default.removeObserver(self)
        notifyPool.removeAll()
        return self
    }

    /*
     switch notification's status
     */
    @discardableResult public func opStatus(_ notifyIdentifier: String, _ open: Bool) -> Self {
        self.notifyStatus[notifyIdentifier] = open
        return self
    }

    /*
     switch all notifacations' status
     */
    @discardableResult public func opStatusForAll(_ open: Bool) -> Self {
        self.notifyStatus.keys.forEach { self.notifyStatus[$0] = open }
        return self
    }

    /** !
     `default`: ZRNotify remove all notification in deinit
     */
    deinit {
        removeAll()
    }
}

extension ZRNotify {
    @objc fileprivate func receiveNotify(_ notification: Notification) {
        for notify in notifyPool {
            guard let status = self.notifyStatus[notify.0], status == true, notify.0 == notification.name.rawValue else {
                continue
            }
            notify.1?(notification)
        }
    }
}
