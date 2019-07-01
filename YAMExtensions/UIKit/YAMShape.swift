//
//  YAMShape.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/29.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import UIKit

enum YAMShape {
    case line
    case circle
    case border
    case mask
    
    /// retuan a line or circle layer
    func layer(WithSize size: CGSize, color: UIColor?) -> CALayer {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        switch self {
        case .line:
            layer.fillColor = color?.cgColor ?? UIColor.darkGray.cgColor
        case .circle:
            path.addArc(withCenter: CGPoint(x: size.width/2, y: size.height/2), radius: size.width/2, startAngle: 0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
            layer.fillColor = color?.cgColor ?? UIColor.black.cgColor
        default:
            break
        }
        layer.path = path.cgPath
        layer.backgroundColor = nil
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return layer
    }
    
    /// return a shapelayer for mask, just for .mask, .border
    func shapeLayer(withSize size: CGSize, radius: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        switch self {
        case .mask:
            layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: radius).cgPath
        case .border:
            layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: radius).cgPath
            layer.lineWidth = 1
            layer.strokeColor = UIColor.gray.cgColor
            layer.fillColor = nil
        default:
            break
        }
        
        return layer
    }
    
    /// return a border layer, just for .mask, .border
    func shapeLayer(withSize size: CGSize, radius: CGFloat, borderWidth: CGFloat, color: UIColor?) -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        switch self {
        case .border:
            layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: radius).cgPath
            layer.lineWidth = borderWidth
            layer.strokeColor = color?.cgColor ?? UIColor.black.cgColor
            layer.fillColor = nil
        case .mask:
            layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: radius).cgPath

        default:
            break
        }
        
        return layer
    }
}
