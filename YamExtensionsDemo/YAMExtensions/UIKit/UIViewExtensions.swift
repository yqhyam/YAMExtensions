//
//  UIViewExtension.swift
//  YamExtensionsDemo
//
//  Created by compassic/YaM on 2017/11/17.
//  Copyright © 2017年 compassic/YaM. All rights reserved.
//

import UIKit

extension YamEx where Base: View {
    
    public var left: CGFloat {
        set{
            var frame = base.frame
            frame.origin.x = newValue
            base.frame = frame
        }
        get{
            return base.frame.origin.x
        }
    }

    public var top: CGFloat {
        set{
            var frame = base.frame
            frame.origin.y = newValue
            base.frame = frame
        }
        get{
            return base.frame.origin.y
        }
    }
    
    public var right: CGFloat {
        set{
            var frame = base.frame
            frame.origin.x = newValue - frame.size.width
            base.frame = frame
        }
        get{
            return base.frame.origin.x + base.frame.size.width
        }
    }
    
    public var bottom: CGFloat {
        set{
            var frame = base.frame
            frame.origin.y = newValue - base.frame.size.height
            base.frame = frame
        }
        get{
            return base.frame.origin.y + base.frame.size.height
        }
    }
    
    public var width: CGFloat {
        set{
            var frame = base.frame
            frame.size.width = newValue
            base.frame = frame
        }
        get{
            return base.frame.size.width
        }
    }
    
    public var height: CGFloat {
        set{
            var frame = base.frame
            frame.size.height = newValue
            base.frame = frame
        }
        get{
            return base.frame.size.height
        }
    }
    
    public var centerX: CGFloat {
        set{
            base.center = CGPoint(x: newValue, y: base.center.y)
        }
        get{
            return base.center.x
        }
    }
    
    public var centerY: CGFloat {
        set{
            base.center = CGPoint(x: base.center.x, y: newValue)
        }
        get{
            return base.center.y
        }
    }
    
    public var origin: CGPoint {
        set{
            var frame = base.frame
            frame.origin = newValue
            base.frame = frame
        }
        get{
            return base.frame.origin
        }
    }
    
    public var size: CGSize {
        set{
            var frame = base.frame
            frame.size = newValue
            base.frame = frame
        }
        get{
            return base.frame.size
        }
    }
    
    public func removeAllSubviews() {
        for view in base.subviews {
            view.removeFromSuperview()
        }
    }
    
    public func snapshotImage() -> UIImage? {
        
        guard base.frame.height > 0 && base.frame.size.width > 0 else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(base.bounds.size, base.isOpaque, 0)
        base.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
        
    }
    
    public func setLayerShadow(color: UIColor, offset: CGSize, radius: CGFloat) {
        
        base.layer.shadowColor = color.cgColor
        base.layer.shadowOffset = offset
        base.layer.shadowRadius = radius
        base.layer.shadowOpacity = 1
        base.layer.shouldRasterize = true
        base.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    func viewController() -> UIViewController? {
        
        if let view = base.superview {
            let nextResponder = view.next
            if (nextResponder?.isKind(of: UIViewController.self))! {
                return nextResponder as? UIViewController
            }
        }
        
        return nil
        
    }
}
