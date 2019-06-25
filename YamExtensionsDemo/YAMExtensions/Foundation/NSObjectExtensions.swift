//
//  ObjectExtension.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/25.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import Foundation

typealias yam_kvoBlock = ((_ obj: Any?, _ oldVal: Any?, _ newVal: Any?) ->Void)

class YAMNSObjectKVOBlockTarget: NSObject {
    
    var block: yam_kvoBlock?
    
    init(with block: @escaping yam_kvoBlock, attachTo: AnyObject) {
        super.init()
        self.block = block
        objc_setAssociatedObject(attachTo, "[\(arc4random()).kvo]", self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if self.block == nil {
                return
            }
        
            if let _ = change?[NSKeyValueChangeKey.notificationIsPriorKey] as? Bool {
                return
            }
        
            if let _ = change?[NSKeyValueChangeKey.kindKey] as? NSKeyValueChange {
                return
            }
        
            let oldVal = change?[NSKeyValueChangeKey.oldKey]
            let newVal = change?[NSKeyValueChangeKey.newKey]
        
            self.block!(object, oldVal, newVal)
    }
}

private var nsobjcet_block_key: Void?


extension NSObject {
    
    class func swizzleInstanceMethod(originalSel: Selector, newSel: Selector) -> Bool {
        let orginalMethod = class_getInstanceMethod(self as AnyClass, originalSel)
        let newMethod = class_getInstanceMethod(self as AnyClass, newSel)
        if orginalMethod != nil || newMethod != nil {
            return false
        }

        class_addMethod(self as AnyClass, originalSel,
                        class_getInstanceMethod(self as AnyClass, originalSel)!,
                        method_getTypeEncoding(orginalMethod!))
        
        class_addMethod(self as AnyClass, newSel,
                        class_getInstanceMethod(self as AnyClass, newSel)!,
                        method_getTypeEncoding(newMethod!))
        
        method_exchangeImplementations(class_getInstanceMethod(self as AnyClass, originalSel)!,
                                       class_getInstanceMethod(self as AnyClass, newSel)!)
        
        return true
    }
    
    class func swizzleClassMethod(originalSel: Selector, newSel: Selector) -> Bool {
        let _class: AnyClass = object_getClass(self)!
        let originalMethod = class_getInstanceMethod(_class, originalSel)
        let newMethod = class_getInstanceMethod(_class, newSel)
        if originalMethod == nil || newMethod == nil {
            return false
        }
        method_exchangeImplementations(originalMethod!, newMethod!)
        return true
    }
    
    // MARK: KVO
    func addObserverBlock(forKeyPath keyPath: String, block: @escaping yam_kvoBlock) {
        if keyPath == "" {
            return
        }
        let target = YAMNSObjectKVOBlockTarget(with: block, attachTo: self)
        var dict = yam_allNSObjectObserverBlocks
        var arr = dict[keyPath]
        if arr == nil {
            arr = []
            dict[keyPath] = arr
        }
        arr?.append(target)
        self.addObserver(target, forKeyPath: keyPath, options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old], context: nil)
    }
    
    func removeObserverBlock(forKeyPath keyPath: String) {
        if keyPath == "" {
            return
        }
        var dict = yam_allNSObjectObserverBlocks
        let arr = dict[keyPath] ?? []
        for item in arr {
            self.removeObserver(item, forKeyPath: keyPath)
        }
        dict.removeValue(forKey: keyPath)
    }
    
    func removeObserverBlocks() {
        var dict = yam_allNSObjectObserverBlocks
        for (key, value) in dict {
            for item in value {
                self.removeObserver(item, forKeyPath: key)
            }
        }
        dict.removeAll()
    }
    
    var yam_allNSObjectObserverBlocks: [String: [YAMNSObjectKVOBlockTarget]] {
        var targets = objc_getAssociatedObject(self, &nsobjcet_block_key) as? [String: [YAMNSObjectKVOBlockTarget]]
        if targets == nil {
            targets = Dictionary()
            objc_setAssociatedObject(self, &nsobjcet_block_key, targets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return targets!
    }
}
