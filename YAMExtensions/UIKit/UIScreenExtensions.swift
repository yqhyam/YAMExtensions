//
//  UIScreen+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/3.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

extension YamEx where Base: Screen {
    
    class var screenScale: CGFloat {
        return UIScreen.main.scale
    }
    
    var currentBounds: CGRect {
        return bounds(for: UIApplication.shared.statusBarOrientation)
    }
    
    func bounds(for orientation: UIInterfaceOrientation) -> CGRect {
        var bounds = base.bounds
        if UIInterfaceOrientationIsLandscape(orientation) {
            let buffer = bounds.size.width
            bounds.size.width = bounds.size.height
            bounds.size.height = buffer
        }
        return bounds
    }
    
    var sizeInPixel: CGSize {
        var size = CGSize.zero
        
        if UIScreen.main.isEqual(base) {
            let model = UIDevice.current.ye.machineModel
            if model.hasPrefix("iPhone") {
                if model.hasPrefix("iPhone1") { size = CGSize(width: 320, height: 480) }
                else if model.hasPrefix("iPhone2") { size = CGSize(width: 320, height: 480) }
                else if model.hasPrefix("iPhone3") { size = CGSize(width: 640, height: 960) }
                else if model.hasPrefix("iPhone4") { size = CGSize(width: 640, height: 960) }
                else if model.hasPrefix("iPhone5") { size = CGSize(width: 640, height: 1136) }
                else if model.hasPrefix("iPhone6") { size = CGSize(width: 640, height: 1136) }
                else if model.hasPrefix("iPhone7,1") { size = CGSize(width: 1080, height: 1920) }
                else if model.hasPrefix("iPhone7,2") { size = CGSize(width: 750, height: 1334) }
                else if model.hasPrefix("iPhone8,1") { size = CGSize(width: 1080, height: 1920) }
                else if model.hasPrefix("iPhone8,2") { size = CGSize(width: 750, height: 1334) }
                else if model.hasPrefix("iPhone8,4") { size = CGSize(width: 640, height: 1136) }
                else if model.hasPrefix("iPhone9,1") { size = CGSize(width: 750, height: 1334) }
                else if model.hasPrefix("iPhone9,3") { size = CGSize(width: 750, height: 1334) }
                else if model.hasPrefix("iPhone9,2") { size = CGSize(width: 1080, height: 1920) }
                else if model.hasPrefix("iPhone9,4") { size = CGSize(width: 1080, height: 1920) }
                else if model.hasPrefix("iPhone10,1") { size = CGSize(width: 750, height: 1334) }
                else if model.hasPrefix("iPhone10,4") { size = CGSize(width: 750, height: 1334) }
                else if model.hasPrefix("iPhone10,2") { size = CGSize(width: 1080, height: 1920) }
                else if model.hasPrefix("iPhone10,5") { size = CGSize(width: 1080, height: 1920) }
                else if model.hasPrefix("iPhone10,3") { size = CGSize(width: 1125, height: 2436) }
                else if model.hasPrefix("iPhone10,6") { size = CGSize(width: 1125, height: 2436) }
            }
            else if model.hasPrefix("iPod") {
                if model.hasPrefix("iPod1") { size = CGSize(width: 320, height: 480) }
                else if model.hasPrefix("iPod2") { size = CGSize(width: 320, height: 480) }
                else if model.hasPrefix("iPod3") { size = CGSize(width: 320, height: 480) }
                else if model.hasPrefix("iPod4") { size = CGSize(width: 640, height: 960) }
                else if model.hasPrefix("iPod5") { size = CGSize(width: 640, height: 1136) }
                else if model.hasPrefix("iPod7") { size = CGSize(width: 640, height: 1136) }
            }
            else if model.hasPrefix("iPad") {
                if model.hasPrefix("iPad1") { size = CGSize(width: 768, height: 1024) }
                else if model.hasPrefix("iPad2") { size = CGSize(width: 768, height: 1024) }
                else if model.hasPrefix("iPad3") { size = CGSize(width: 1536, height: 2048) }
                else if model.hasPrefix("iPad4") { size = CGSize(width: 1536, height: 2048) }
                else if model.hasPrefix("iPad5") { size = CGSize(width: 1536, height: 2048) }
                else if model.hasPrefix("iPad6,3") { size = CGSize(width: 1536, height: 2048) }
                else if model.hasPrefix("iPad6,4") { size = CGSize(width: 1536, height: 2048) }
                else if model.hasPrefix("iPad6,7") { size = CGSize(width: 2048, height: 2732) }
                else if model.hasPrefix("iPad6,8") { size = CGSize(width: 2048, height: 2732) }
                else if model.hasPrefix("iPad7,1") { size = CGSize(width: 2048, height: 2732) }
                else if model.hasPrefix("iPad7,2") { size = CGSize(width: 2048, height: 2732) }
                else if model.hasPrefix("iPad7,3") { size = CGSize(width: 1668, height: 2224) }
                else if model.hasPrefix("iPad7,4") { size = CGSize(width: 1668, height: 2224) }
            }
        }
        
        if __CGSizeEqualToSize(size, CGSize.zero) {
            if base.responds(to: #selector(getter: UIScreen.nativeBounds)) {
                size = base.nativeBounds.size
            } else {
                size = base.bounds.size
                size.width *= base.scale
                size.height *= base.scale
            }
            if size.height < size.width {
                let tmp: CGFloat = size.height
                size.height = size.width
                size.width = tmp
            }
        }
        return size
    }
    
    var pixelsPerInch: CGFloat {
        
        var ppi: CGFloat = 0
        if UIScreen.main.isEqual(base) {
            let model = UIDevice.current.ye.machineModel
            if model.hasPrefix("iPhone") {
                if model.hasPrefix("iPhone1") { ppi = 163 }
                else if model.hasPrefix("iPhone2") { ppi = 163 }
                else if model.hasPrefix("iPhone3") { ppi = 326 }
                else if model.hasPrefix("iPhone4") { ppi = 326 }
                else if model.hasPrefix("iPhone5") { ppi = 326 }
                else if model.hasPrefix("iPhone6") { ppi = 326 }
                else if model.hasPrefix("iPhone7,1") { ppi = 401 }
                else if model.hasPrefix("iPhone7,2") { ppi = 326 }
                else if model.hasPrefix("iPhone8,1") { ppi = 401 }
                else if model.hasPrefix("iPhone8,2") { ppi = 326 }
                else if model.hasPrefix("iPhone8,4") { ppi = 326 }
                else if model.hasPrefix("iPhone9,1") { ppi = 326 }
                else if model.hasPrefix("iPhone9,3") { ppi = 326 }
                else if model.hasPrefix("iPhone9,2") { ppi = 401 }
                else if model.hasPrefix("iPhone9,4") { ppi = 401 }
                else if model.hasPrefix("iPhone10,1") { ppi = 326 }
                else if model.hasPrefix("iPhone10,4") { ppi = 326 }
                else if model.hasPrefix("iPhone10,2") { ppi = 401 }
                else if model.hasPrefix("iPhone10,5") { ppi = 401 }
                else if model.hasPrefix("iPhone10,3") { ppi = 458 }
                else if model.hasPrefix("iPhone10,6") { ppi = 458 }
            }
            else if model.hasPrefix("iPod") {
                if model.hasPrefix("iPod1") { ppi = 163 }
                else if model.hasPrefix("iPod2") { ppi = 163 }
                else if model.hasPrefix("iPod3") { ppi = 163 }
                else if model.hasPrefix("iPod4") { ppi = 326 }
                else if model.hasPrefix("iPod5") { ppi = 326 }
                else if model.hasPrefix("iPod7") { ppi = 326 }
            }
            else if model.hasPrefix("iPad") {
                if model.hasPrefix("iPad1") { ppi = 132 }
                else if model.hasPrefix("iPad2") { ppi = 132 }
                else if model.hasPrefix("iPad3") { ppi = 132 }
                else if model.hasPrefix("iPad4") { ppi = 132 }
                else if model.hasPrefix("iPad5") { ppi = 264 }
                else if model.hasPrefix("iPad6,3") { ppi = 264 }
                else if model.hasPrefix("iPad6,4") { ppi = 264 }
                else if model.hasPrefix("iPad6,7") { ppi = 264 }
                else if model.hasPrefix("iPad6,8") { ppi = 264 }
                else if model.hasPrefix("iPad7,1") { ppi = 264 }
                else if model.hasPrefix("iPad7,2") { ppi = 264 }
                else if model.hasPrefix("iPad7,3") { ppi = 264 }
                else if model.hasPrefix("iPad7,4") { ppi = 264 }
            }
        }
        return (ppi == 0) ? 326 : ppi
    }
}
