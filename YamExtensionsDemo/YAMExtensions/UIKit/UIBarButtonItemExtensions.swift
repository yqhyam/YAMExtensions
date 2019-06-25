//
//  UIBarButtonItemEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/2.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

private var barButtomItemBlockKey: Void?

class YAMUIBarButtonItemBlockTarget {
    
    typealias itemBlock = ((_ sender: UIBarButtonItem) -> Void)
    var block: itemBlock!
    
    init(attachTo: Any, block: @escaping itemBlock) {
        
        self.block = block
        objc_setAssociatedObject(attachTo, "[\(arc4random()).barButtomItem]", self, .OBJC_ASSOCIATION_RETAIN)
    }
    
    @objc func invoke(sender: UIBarButtonItem) {
        guard let block = self.block else {
            return
        }
        block(sender)
    }
}

extension YamEx where Base: BarButtonItem {
    
    public var actionBlock: (_ sender: UIBarButtonItem) -> () {
        set{
            let target = YAMUIBarButtonItemBlockTarget(attachTo: base, block: newValue)
            objc_setAssociatedObject(base, &barButtomItemBlockKey, target, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            base.target = target
            base.action = #selector(YAMUIBarButtonItemBlockTarget.invoke(sender:))
        }
        get{
            let target = objc_getAssociatedObject(base, &barButtomItemBlockKey) as? YAMUIBarButtonItemBlockTarget
            return (target?.block)!
        }
    }
    
}

