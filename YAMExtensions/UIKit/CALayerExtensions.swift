//
//  CALayerEx.swift
//  YamExtensionsDemo
//
//  Created by compassic/YaM on 2017/11/17.
//  Copyright © 2017年 compassic/YaM. All rights reserved.
//

import UIKit

extension CALayer {

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
            var frame = self.frame
            frame.origin.x = newValue - self.frame.size.width * 0.5
            self.frame = frame
        }
        get{
            return self.frame.origin.x + self.frame.size.width * 0.5
        }
    }
    
    public var centerY: CGFloat {
        set{
            var frame = self.frame
            frame.origin.y = newValue - self.frame.size.height * 0.5
            self.frame = frame
        }
        get{
            return self.frame.origin.y + self.frame.size.height * 0.5
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
    
    public var transformRotation: CGFloat {
        set{
            self.setValue(newValue, forKeyPath: "transform.rotation")
        }
        get{
            let v = self.value(forKeyPath: "transform.rotation")
            return v as! CGFloat
        }
    }
    
    public func removeAllSublayers() {
        for layer in self.sublayers! {
            layer.removeFromSuperlayer()
        }
    }
    
    public func setLayerShadow(color: UIColor, offset: CGSize, radius: CGFloat) {
        
        self.shadowColor = color.cgColor
        self.shadowOffset = offset
        self.shadowRadius = radius
        self.shadowOpacity = 1
        self.shouldRasterize = true
        self.rasterizationScale = UIScreen.main.scale
        
    }
    
    public func snapshotImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.render(in: UIGraphicsGetCurrentContext()!)
        
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap!
        
    }
    
    public func addFadeAnimation(with duration: TimeInterval, curve: UIView.AnimationCurve) {
        
        if duration <= 0 {
            return
        }
        
        var mediaFunction: CAMediaTimingFunctionName = .default
        
        switch curve {
            
        case .easeInOut:
            mediaFunction = CAMediaTimingFunctionName.easeInEaseOut
        case .easeIn:
            mediaFunction = CAMediaTimingFunctionName.easeIn
        case .easeOut:
            mediaFunction = CAMediaTimingFunctionName.easeOut
        case .linear:
            mediaFunction = CAMediaTimingFunctionName.linear
        default:
            break
        }
        
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: mediaFunction)
        transition.type = CATransitionType.fade
        self.add(transition, forKey: "yam.fade")
        
    }
    
    public func removePreviousFadeAnimation() {
        self.removeAnimation(forKey: "yam.fade")
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
    class func layer(withText text: String, mode: CATextLayerAlignmentMode, font: UIFont) -> CATextLayer {
        
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
