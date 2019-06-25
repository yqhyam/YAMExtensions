//
//  UIControlEx.swift
//  YamExtensionsDemo
//
//  Created by compassic/YaM on 2017/11/21.
//  Copyright © 2017年 compassic/YaM. All rights reserved.
//

import UIKit

class YAMUIControllBlockTarget {
    
    var block: yam_controlBlock!
    var events: UIControlEvents!
    
    init(attachTo: AnyObject,block: @escaping yam_controlBlock, events: UIControlEvents) {
        
        self.block = block
        self.events = events
        
        //避免被提前释放
        objc_setAssociatedObject(attachTo, "[\(arc4random()).control]", self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    deinit {
        print("UIControllTarget be released")
    }
    
    @objc func invoke(sender: Any) {
        guard let block = self.block else {
            return
        }
        block(sender)
    }
    
}

private var yam_controllKey: Void?
typealias yam_controlBlock = ((_ sender: Any) -> Void)

extension YamEx where Base: Control {
    
    fileprivate var invoke: Selector {
        return #selector(YAMUIControllBlockTarget.invoke(sender:))
    }
    
    /**
     添加一个闭包
     */
    func addBlock(for events: UIControlEvents, block: @escaping yam_controlBlock){
        
        let target = YAMUIControllBlockTarget(attachTo: base, block: block, events: events)
        base.addTarget(target, action: invoke, for: events)
        
        var array = yam_allUIControlBlockTargets()
        array.append(target)
    }
    
    func setBlock(for events: UIControlEvents, block: @escaping yam_controlBlock){
        
        self.addBlock(for: events, block: block)
    }
    
    func setTarget(_ target: Any, action: Selector, for controlEvents: UIControlEvents){
        
        let targets = base.allTargets
        for currrentTarget in targets {
            guard let actions = base.actions(forTarget: currrentTarget, forControlEvent: controlEvents) else {
                return
            }
            for currentAction in actions {
                base.removeTarget(currrentTarget, action: NSSelectorFromString(currentAction), for: controlEvents)
            }
        }
        base.addTarget(target, action: action, for: controlEvents)
    }
    
    func removeAllBlocks(for eveents: UIControlEvents) {
        
        let targets = yam_allUIControlBlockTargets()
        var removes = Array<YAMUIControllBlockTarget>()
        for target in targets {
            guard let newEvent = target.events else {
                base.removeTarget(target, action: invoke, for: target.events)
                removes.append(target)
                return
            }
            base.removeTarget(target, action: invoke, for: target.events)
            target.events = newEvent
            base.addTarget(target, action: invoke, for: target.events)
        }
        
    }
    
    func removeAllTargets() {
        
        for obj in base.allTargets {
            base.removeTarget(obj, action: nil, for: .allEvents)
        }
        
        var array = yam_allUIControlBlockTargets()
        array.removeAll()
    }
    
    fileprivate func yam_allUIControlBlockTargets() -> Array<YAMUIControllBlockTarget> {

        var targets = objc_getAssociatedObject(self, &yam_controllKey) as? Array<YAMUIControllBlockTarget>

        if targets == nil {
            targets = []
            objc_setAssociatedObject(self, &yam_controllKey, targets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        return targets!
    }
}
