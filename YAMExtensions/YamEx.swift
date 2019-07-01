//
//  YamExtension.swift
//  YamExtensionsDemo
//
//  Created by compassic/YaM on 2017/11/17.
//  Copyright © 2017年 compassic/YaM. All rights reserved.
//

import UIKit

public typealias View = UIView
public typealias Layer = CALayer
public typealias Color = UIColor
public typealias BarButtonItem = UIBarButtonItem
public typealias Control = UIControl
public typealias GestureRecognizer = UIGestureRecognizer
public typealias ScrollView = UIScrollView
public typealias TableView = UITableView
public typealias TextField = UITextField
public typealias Screen = UIScreen
public typealias Device = UIDevice
public typealias Application = UIApplication
public typealias Font = UIFont
public typealias BezierPath = UIBezierPath
public typealias Image = UIImage
public typealias Button = UIButton

public final class YamEx<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol YamExCompatible {
    associatedtype CompatibleType
    var ye: CompatibleType { get }
    static var ye: CompatibleType.Type { get }
}

public extension YamExCompatible {
    public var ye: YamEx<Self> {
        get { return YamEx(self) }
        set { }
    }
    
    static var ye: YamEx<Self>.Type {
        return YamEx.self
    }
}

extension View: YamExCompatible {}
extension Layer: YamExCompatible {}
extension Color: YamExCompatible {}
extension BarButtonItem: YamExCompatible {}
extension Control: YamExCompatible {}
extension GestureRecognizer: YamExCompatible {}
extension ScrollView: YamExCompatible {}
extension TableView: YamExCompatible {}
extension TextField: YamExCompatible {}
extension Screen: YamExCompatible {}
extension Device: YamExCompatible {}
extension Application: YamExCompatible {}
extension Font: YamExCompatible {}
extension Image: YamExCompatible {}
extension Button: YamExCompatible {}
