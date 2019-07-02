//
//  UIScrollView+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/2.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func scrollToTop(isAnimated: Bool) {
        var off = self.contentOffset
        off.y = 0 - self.contentInset.top
        self.setContentOffset(off, animated: isAnimated)
    }
    
    func scrollToLeft(isAnimated: Bool) {
        var off = self.contentOffset
        off.x = 0 - self.contentInset.left
        self.setContentOffset(off, animated: isAnimated)
    }
    
    func scrollToBottom(isAnimated: Bool) {
        var off = self.contentOffset
        off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom
        self.setContentOffset(off, animated: isAnimated)
    }
    
    func scrollToRight(isAnimated: Bool) {
        var off = self.contentOffset
        off.x = self.contentSize.width - self.bounds.width + self.contentInset.right
        self.setContentOffset(off, animated: isAnimated)
    }
    
    func scrollToTop() {
        scrollToTop(isAnimated: true)
    }
    
    func scrollToLeft() {
        scrollToLeft(isAnimated: true)
    }
    
    func scrollToBottom() {
        scrollToBottom(isAnimated: true)
    }
    
    func scrollToRight() {
        scrollToRight(isAnimated: true)
    }
}
