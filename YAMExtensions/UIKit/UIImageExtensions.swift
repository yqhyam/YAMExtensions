//
//  UIImageExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/22.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import UIKit
import Accelerate

extension UIImage {
    
    class func image(withColor color: UIColor) -> UIImage? {
        return self.image(withColor: color, size: CGSize(width: 1, height: 1))
    }
    
    class func image(withColor color: UIColor, size: CGSize) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension YamEx where Base: Image {
    
    /**
     check if has alpha
     */
    func hasAlphaChannel() -> Bool {
        if base.cgImage == nil {
            return false
        }
        let alpha = base.cgImage?.alphaInfo
        return (alpha == CGImageAlphaInfo.first ||
            alpha == .last ||
            alpha == CGImageAlphaInfo.premultipliedFirst ||
            alpha == CGImageAlphaInfo.premultipliedLast)
    }
    
    /// return a cicle image
    func toCicle() -> UIImage? {
        let mins = min(base.size.width, base.size.height)
        return image(byRoundCorner: mins / 2.0, borderWidth: 0, borderColor: nil)
    }
    
    func image(byRoundCorner radius: CGFloat) -> UIImage? {
        return image(byRoundCorner: radius, borderWidth: 0, borderColor: nil)
    }
    
    func image(byRoundCorner radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor?) -> UIImage? {
        return image(byRoundCorner: radius, corners: UIRectCorner.allCorners, borderWidth: borderWidth, borderColor: borderColor, borderLineJoin: CGLineJoin.miter)
    }
    
    fileprivate func image(byRoundCorner radius: CGFloat, corners: UIRectCorner, borderWidth: CGFloat, borderColor: UIColor?, borderLineJoin: CGLineJoin) -> UIImage? {
        var newCorners = corners
        if base.cgImage == nil {
            return nil
        }
        if corners != .allCorners {
            var temp: UIRectCorner = []
            if (corners.rawValue & UIRectCorner.topLeft.rawValue == 1) {
                temp = UIRectCorner(rawValue: UIRectCorner.bottomLeft.rawValue | temp.rawValue)
            }
            if (corners.rawValue & UIRectCorner.topRight.rawValue == 1) {
                temp = UIRectCorner(rawValue: UIRectCorner.topRight.rawValue | temp.rawValue)
            }
            if (corners.rawValue & UIRectCorner.bottomLeft.rawValue == 1) {
                temp = UIRectCorner(rawValue: UIRectCorner.bottomLeft.rawValue | temp.rawValue)
            }
            if (corners.rawValue & UIRectCorner.bottomRight.rawValue == 1) {
                temp = UIRectCorner(rawValue: UIRectCorner.bottomRight.rawValue | temp.rawValue)
            }
            newCorners = temp
        }
        
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -rect.size.height)
        
        let minSize = min(base.size.width, base.size.height)
        if borderWidth < minSize / 2 {
            let path = UIBezierPath(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth), byRoundingCorners: newCorners, cornerRadii: CGSize(width: radius, height: radius))
            path.close()
            
            context?.saveGState()
            path.addClip()
            context?.draw(base.cgImage!, in: rect)
            context?.restoreGState()
        }
        
        if borderColor != nil && borderWidth < minSize / 2 && borderWidth > 0 {
            let strokeInset = (floor(borderWidth * base.scale) + 0.5) / base.scale
            let strokeRect = rect.insetBy(dx: strokeInset, dy: strokeInset)
            let strokeRadius = radius > base.scale / 2 ? radius - base.scale / 2 : 0
            let path = UIBezierPath(roundedRect: strokeRect, byRoundingCorners: corners, cornerRadii: CGSize(width: strokeRadius, height: borderWidth))
            path.close()
            path.lineWidth = borderWidth
            path.lineJoinStyle = borderLineJoin
            borderColor!.setStroke()
            path.stroke()
        }
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    func image(byResize size: CGSize) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, base.scale)
        base.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    func image(byResize size: CGSize, contentMode: UIViewContentMode) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, base.scale)
        draw(inRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), contentMode: contentMode, clips: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    func draw(inRect rect: CGRect, contentMode: UIViewContentMode, clips: Bool) {
        let drawRect = YAMCGRectFit(WithContentMode: rect, size: base.size, mode: contentMode)
        if drawRect.size.width == 0 || drawRect.size.height == 0 {
            return
        }
        if clips {
            if let context = UIGraphicsGetCurrentContext() {
                context.saveGState()
                context.addRect(rect)
                context.clip()
                base.draw(in: drawRect)
                context.restoreGState()
            }
        } else {
            base.draw(in: drawRect)
        }
    }
    
    fileprivate func DegressToRadians(degress: CGFloat) -> CGFloat {
        return degress * CGFloat.pi / 180
    }
    
    func rotateLeft90() -> UIImage? {
        return image(byRotate: DegressToRadians(degress: 90), fitSize: true)
    }
    
    func rotateRight90() -> UIImage? {
        return image(byRotate: DegressToRadians(degress: -90), fitSize: true)
    }
    
    func rotate180() -> UIImage? {
        return flip(horizontal: true, vertical: true)
    }
    
    func flipVerical() -> UIImage? {
        return flip(horizontal: false, vertical: true)
    }
    
    func flipHorizontal() -> UIImage? {
        return flip(horizontal: true, vertical: false)
    }
    
    fileprivate func flip(horizontal: Bool, vertical: Bool) -> UIImage? {
        if base.cgImage == nil {
            return nil
        }
        let width = base.cgImage?.width ?? 0
        let height = base.cgImage?.height ?? 0
        let bytesPerRow = width * 4
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: nil,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue) else {
            return nil
        }
        context.draw(base.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let data = context.data else {
            return nil
        }
        var src = vImage_Buffer(data: data, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: bytesPerRow)
        var dest = vImage_Buffer(data: data, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: bytesPerRow)
        if horizontal {
            vImageVerticalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill))
        }
        if vertical {
            vImageHorizontalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill))
        }
        if let imgRef = context.makeImage() {
            let img = UIImage.init(cgImage: imgRef, scale: base.scale, orientation: base.imageOrientation)
            return img
        }
        return nil
    }
    
    func image(byRotate radians: CGFloat, fitSize: Bool) -> UIImage? {
        if base.cgImage == nil {
            return nil
        }
        let width = base.cgImage?.width ?? 0
        let height = base.cgImage?.height ?? 0
        let rect = CGRect(x: 0, y: 0, width: width, height: height).applying(fitSize ? CGAffineTransform(rotationAngle: radians) : CGAffineTransform.identity)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: nil,
                                width: Int(rect.size.width),
                                height: Int(rect.size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: Int(rect.size.width) * 4,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue) else {
                                    return nil
        }
        context.setShouldAntialias(true)
        context.setAllowsAntialiasing(true)
        context.interpolationQuality = CGInterpolationQuality.high
        context.translateBy(x: +(rect.size.width * 0.5), y: +(rect.size.height * 0.5))
        context.rotate(by: radians)
        
        context.draw(base.cgImage!, in: CGRect(x: -(Double(width) * 0.5), y: -(Double(height) * 0.5), width: Double(width), height: Double(height)))
        if let imgRef = context.makeImage() {
            let img = UIImage(cgImage: imgRef, scale: base.scale, orientation: base.imageOrientation)
            return img
        }
        return nil
    }
    
    func image(byTintColor color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        let rect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        color.set()
        UIRectFill(rect)
        base.draw(at: CGPoint(x: 0, y: 0), blendMode: CGBlendMode.destinationIn, alpha: 1)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
}
