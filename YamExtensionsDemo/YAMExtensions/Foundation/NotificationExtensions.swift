//
//  NotificationExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/26.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import Foundation

extension NotificationCenter {
    
    func postNotification(OnMainThreadWithName name: NSNotification.Name, object: Any, userInfo: [String: String]) {
        if pthread_main_np() == 1 {
            return self.post(name: name, object: object, userInfo: userInfo)
        }
        self.postNotification(OnMainThreadWithName: name, object: object as AnyObject, userInfo: userInfo, wait: false)
    }
    
    fileprivate func postNotification(OnMainThreadWithName name: NSNotification.Name, object: AnyObject, userInfo: [String: String], wait: Bool) {
        if pthread_main_np() == 1 {
            return self.post(name: name, object: object, userInfo: userInfo)
        }
        var info = [String: Any](minimumCapacity: 3)
        info["name"] = name
        info["object"] = object
        info["userInfo"] = userInfo
        self.performSelector(onMainThread: #selector(NotificationCenter.yam_postNotificationName(info:)), with: info, waitUntilDone: wait)
    }
    
    @objc class func yam_postNotificationName(info: [String: Any]) {
        let name = info["name"]
        let object = info["object"]
        let userInfo = info["userInfo"]
        self.default.post(name: name as! NSNotification.Name, object: object, userInfo: userInfo as? [AnyHashable : Any])
    }
}
