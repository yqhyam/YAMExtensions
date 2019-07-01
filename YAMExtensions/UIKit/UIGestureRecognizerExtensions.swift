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

extension YamEx where Base: GestureRecognizer {
    
    fileprivate var invoke: Selector {
        return #selector(YAMUIGestureRecognizerBlockTarget.invoke(_:))
    }
    
    func addAction(block: @escaping (_ sender: Any) -> ()) {
        
        let target = YAMUIGestureRecognizerBlockTarget(attachTo: base, block: block)
        base.addTarget(target, action: invoke)
        
        var targets = yam_allUIGestureRecognizerBlockTargets()
        targets.append(target)
    }
    
    func removeAllActionBlocks() {
        
        var targets = yam_allUIGestureRecognizerBlockTargets()
        for target in targets {
            base.removeTarget(target, action: invoke)
        }
        targets.removeAll()
    }
    
    fileprivate func yam_allUIGestureRecognizerBlockTargets() -> [YAMUIGestureRecognizerBlockTarget] {
        guard var targets = objc_getAssociatedObject(base, &gestureRecognizerArrayKey) else { return [] }
        targets = []
        objc_setAssociatedObject(base, &gestureRecognizerArrayKey, targets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return targets as! [YAMUIGestureRecognizerBlockTarget]
    }
}

extension UIGestureRecognizer {

    convenience init(with action: @escaping (_ sender: Any) -> ()) {
        self.init()
        self.ye.addAction(block: action)
    }
}
