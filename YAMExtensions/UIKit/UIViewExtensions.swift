//
//  UIViewExtension.swift
//  YamExtensionsDemo
//
//  Created by compassic/YaM on 2017/11/17.
//  Copyright © 2017年 compassic/YaM. All rights reserved.
//

import UIKit

extension UIView {
    
    public var left: CGFloat {
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin.x
        }
    }

    public var top: CGFloat {
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin.y
        }
    }
    
    public var right: CGFloat {
        set{
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    public var bottom: CGFloat {
        set{
            var frame = self.frame
            frame.origin.y = newValue - self.frame.size.height
            self.frame = frame
        }
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    public var width: CGFloat {
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get{
            return self.frame.size.width
        }
    }
    
    public var height: CGFloat {
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get{
            return self.frame.size.height
        }
    }
    
    public var centerX: CGFloat {
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
        get{
            return self.center.x
        }
    }
    
    public var centerY: CGFloat {
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
        get{
            return self.center.y
        }
    }
    
    public var origin: CGPoint {
        set{
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin
        }
    }
    
    public var size: CGSize {
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get{
            return self.frame.size
        }
    }
    
    public func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    public func snapshotImage() -> UIImage? {
        
        guard self.frame.height > 0 && self.frame.size.width > 0 else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
        
    }
    
    public func setLayerShadow(color: UIColor, offset: CGSize, radius: CGFloat) {
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    func viewController() -> UIViewController? {
        
        if let view = self.superview {
            let nextResponder = view.next
            if (nextResponder?.isKind(of: UIViewController.self))! {
                return nextResponder as? UIViewController
            }
        }
        
        return nil
        
    }
}
