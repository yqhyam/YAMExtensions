//
//  CALayerEx.swift
//  YamExtensionsDemo
//
//  Created by compassic/YaM on 2017/11/17.
//  Copyright © 2017年 compassic/YaM. All rights reserved.
//

import UIKit

extension YamEx where Base: Layer {

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
            var frame = base.frame
            frame.origin.x = newValue - base.frame.size.width * 0.5
            base.frame = frame
        }
        get{
            return base.frame.origin.x + base.frame.size.width * 0.5
        }
    }
    
    public var centerY: CGFloat {
        set{
            var frame = base.frame
            frame.origin.y = newValue - base.frame.size.height * 0.5
            base.frame = frame
        }
        get{
            return base.frame.origin.y + base.frame.size.height * 0.5
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
    
    public var transformRotation: CGFloat {
        set{
            base.setValue(newValue, forKeyPath: "transform.rotation")
        }
        get{
            let v = base.value(forKeyPath: "transform.rotation")
            return v as! CGFloat
        }
    }
    
    public func removeAllSublayers() {
        for layer in base.sublayers! {
            layer.removeFromSuperlayer()
        }
    }
    
    public func setLayerShadow(color: UIColor, offset: CGSize, radius: CGFloat) {
        
        base.shadowColor = color.cgColor
        base.shadowOffset = offset
        base.shadowRadius = radius
        base.shadowOpacity = 1
        base.shouldRasterize = true
        base.rasterizationScale = UIScreen.main.scale
        
    }
    
    public func snapshotImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(base.bounds.size, base.isOpaque, 0)
        base.render(in: UIGraphicsGetCurrentContext()!)
        
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap!
        
    }
    
    public func addFadeAnimation(with duration: TimeInterval, curve: UIViewAnimationCurve) {
        
        if duration <= 0 {
            return
        }
        
        var mediaFunction: String = ""
        
        switch curve {
            
        case .easeInOut:
            mediaFunction = kCAMediaTimingFunctionEaseInEaseOut
        case .easeIn:
            mediaFunction = kCAMediaTimingFunctionEaseIn
        case .easeOut:
            mediaFunction = kCAMediaTimingFunctionEaseOut
        case .linear:
            mediaFunction = kCAMediaTimingFunctionLinear
        }
        
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: mediaFunction)
        transition.type = kCATransitionFade
        base.add(transition, forKey: "yam.fade")
        
    }
    
    public func removePreviousFadeAnimation() {
        base.removeAnimation(forKey: "yam.fade")
    }
}

extension CALayer {
    /// return a image layer
    class func layer(withImage image: UIImage) -> CALayer {
        let layer = CALayer()
        layer.contents = image.cgImage
        layer.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        return layer
    }
}

extension CATextLayer {
    /// retuan a text layer
    class func layer(withText text: String, mode: String, font: UIFont) -> CATextLayer {
        
        let layer = CATextLayer()
        layer.string = text
        layer.alignmentMode = mode
        layer.foregroundColor = UIColor.darkText.cgColor
        layer.contentsScale = UIScreen.main.scale
        layer.isWrapped = true
        
        let fontRef = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        layer.font = fontRef
        layer.fontSize = font.pointSize
        return layer
    }
}
