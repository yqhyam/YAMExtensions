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
    
    /**
     check if has alpha
     */
    func hasAlphaChannel() -> Bool {
        if self.cgImage == nil {
            return false
        }
        let alpha = self.cgImage?.alphaInfo
        return (alpha == CGImageAlphaInfo.first ||
            alpha == .last ||
            alpha == CGImageAlphaInfo.premultipliedFirst ||
            alpha == CGImageAlphaInfo.premultipliedLast)
    }
    
    /// return a cicle image
    func toCicle() -> UIImage? {
        let mins = min(self.size.width, self.size.height)
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
        if self.cgImage == nil {
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
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -rect.size.height)
        
        let minSize = min(self.size.width, self.size.height)
        if borderWidth < minSize / 2 {
            let path = UIBezierPath(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth), byRoundingCorners: newCorners, cornerRadii: CGSize(width: radius, height: radius))
            path.close()
            
            context?.saveGState()
            path.addClip()
            context?.draw(self.cgImage!, in: rect)
            context?.restoreGState()
        }
        
        if borderColor != nil && borderWidth < minSize / 2 && borderWidth > 0 {
            let strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale
            let strokeRect = rect.insetBy(dx: strokeInset, dy: strokeInset)
            let strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0
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
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    func image(byResize size: CGSize, contentMode: UIView.ContentMode) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        draw(inRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), contentMode: contentMode, clips: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    func draw(inRect rect: CGRect, contentMode: UIView.ContentMode, clips: Bool) {
        let drawRect = YAMCGRectFit(WithContentMode: rect, size: self.size, mode: contentMode)
        if drawRect.size.width == 0 || drawRect.size.height == 0 {
            return
        }
        if clips {
            if let context = UIGraphicsGetCurrentContext() {
                context.saveGState()
                context.addRect(rect)
                context.clip()
                self.draw(in: drawRect)
                context.restoreGState()
            }
        } else {
            self.draw(in: drawRect)
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
        if self.cgImage == nil {
            return nil
        }
        let width = self.cgImage?.width ?? 0
        let height = self.cgImage?.height ?? 0
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
        context.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
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
            let img = UIImage.init(cgImage: imgRef, scale: self.scale, orientation: self.imageOrientation)
            return img
        }
        return nil
    }
    
    func image(byRotate radians: CGFloat, fitSize: Bool) -> UIImage? {
        if self.cgImage == nil {
            return nil
        }
        let width = self.cgImage?.width ?? 0
        let height = self.cgImage?.height ?? 0
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
        
        context.draw(self.cgImage!, in: CGRect(x: -(Double(width) * 0.5), y: -(Double(height) * 0.5), width: Double(width), height: Double(height)))
        if let imgRef = context.makeImage() {
            let img = UIImage(cgImage: imgRef, scale: self.scale, orientation: self.imageOrientation)
            return img
        }
        return nil
    }
    
    func image(byTintColor color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        color.set()
        UIRectFill(rect)
        self.draw(at: CGPoint(x: 0, y: 0), blendMode: CGBlendMode.destinationIn, alpha: 1)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
}
