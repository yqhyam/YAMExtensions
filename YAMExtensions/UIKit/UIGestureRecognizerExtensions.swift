//
//  UIGestureRecognizer+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/2.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

private var gestureRecognizerTargetKey: Void?
private var gestureRecognizerArrayKey: Void?

class YAMUIGestureRecognizerBlockTarget {
    
    var block: (_ sender: Any) -> ()
    
    init(attachTo: Any, block: @escaping (_ sender: Any) -> ()) {
        self.block = block
        objc_setAssociatedObject(attachTo, "[\(arc4random()).gestureRecognizer]", self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc func invoke(_ sender: Any) {
        block(sender)
    }
}

extension UIGestureRecognizer {
    
    fileprivate var invoke: Selector {
        return #selector(YAMUIGestureRecognizerBlockTarget.invoke(_:))
    }
    
    func addAction(block: @escaping (_ sender: Any) -> ()) {
        
        let target = YAMUIGestureRecognizerBlockTarget(attachTo: self, block: block)
        self.addTarget(target, action: invoke)
        
        var targets = yam_allUIGestureRecognizerBlockTargets()
        targets.append(target)
    }
    
    func removeAllActionBlocks() {
        
        var targets = yam_allUIGestureRecognizerBlockTargets()
        for target in targets {
            self.removeTarget(target, action: invoke)
        }
        targets.removeAll()
    }
    
    fileprivate func yam_allUIGestureRecognizerBlockTargets() -> [YAMUIGestureRecognizerBlockTarget] {
        guard var targets = objc_getAssociatedObject(self, &gestureRecognizerArrayKey) else { return [] }
        targets = []
        objc_setAssociatedObject(self, &gestureRecognizerArrayKey, targets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return targets as! [YAMUIGestureRecognizerBlockTarget]
    }
}

extension UIGestureRecognizer {

    convenience init(with action: @escaping (_ sender: Any) -> ()) {
        self.init()
        self.addAction(block: action)
    }
}
