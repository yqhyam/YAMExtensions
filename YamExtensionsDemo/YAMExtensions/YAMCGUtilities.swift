//
//  YAMCGUtilities.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/22.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import UIKit

func YAMCGRectFit(WithContentMode rect: CGRect, size: CGSize, mode: UIViewContentMode) -> CGRect {
    var newRect = rect.standardized
    var newSize = CGSize(width: size.width < 0 ? -size.width : size.width, height: size.height < 0 ? -size.height : size.height)
    let center = CGPoint(x: newRect.midX, y: newRect.midY)
    switch mode {
    case .scaleAspectFit:
        break
    case .scaleAspectFill:
        if newRect.size.width < 0.01 || newRect.size.height < 0.01 || newSize.width < 0.01 || newSize.height < 0.01 {
            newRect.origin = center
            newRect.size = CGSize.zero
        } else {
            var scale: CGFloat = 0
            if mode == .scaleAspectFit {
                if newSize.width / newSize.height < newRect.size.width / newRect.size.height {
                    scale = newRect.size.height / newSize.height
                } else {
                    scale = newRect.size.width / newSize.width
                }
            } else {
                if newSize.width / newSize.height < newRect.size.width / newRect.size.height {
                    scale = newRect.size.width / newSize.width
                } else {
                    scale = newRect.size.height / newSize.height
                }
            }
            newSize.width *= scale
            newSize.height *= scale
            newRect.size = newSize
            newRect.origin = CGPoint(x: center.x - newSize.width * 0.5, y: center.y - newSize.height * 0.5)
        }
        break
    case .center:
        newRect.size = newSize
        newRect.origin = CGPoint(x: center.x - newSize.width * 0.5, y: center.y - newSize.height * 0.5)
        break
    case .top:
        newRect.origin.x = center.x - newSize.width * 0.5
        newRect.size = newSize
        break
    case.bottom:
        newRect.origin.x = center.x - newSize.width * 0.5
        newRect.origin.y += newRect.size.height - newSize.height
        newRect.size = newSize
        break
    case .left:
        newRect.origin.y = center.y - size.height * 0.5
        newRect.size = size
        break
    case .right:
        newRect.origin.y = center.y - newSize.height * 0.5
        newRect.origin.x += newRect.size.width - newSize.width
        newRect.size = newSize
    case .topLeft:
        newRect.size = newSize
        break
    case .topRight:
        newRect.origin.x += newRect.size.width - newSize.width
        newRect.size = newSize
        break
    case .bottomLeft:
        newRect.origin.y += newRect.size.width - newSize.height
        newRect.size = newSize
        break
    case .bottomRight:
        newRect.origin.x += newRect.size.width - newSize.width
        newRect.origin.y += newRect.size.height - newSize.height
        newRect.size = newSize
        break
    case .scaleToFill:
        break
    case .redraw:
        break
    default:
        break
    }
    
    return newRect
}

extension Double {
    /// 保留X位小数
    func roundTo(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
