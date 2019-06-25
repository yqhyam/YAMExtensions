//
//  UINavigationControllerExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/29.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var childViewControllerForStatusBarStyle: UIViewController?{
        return self.topViewController
    }
    
    open override var childViewControllerForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}
