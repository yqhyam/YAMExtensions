//
//  UIScrollView+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/2.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

extension YamEx where Base: ScrollView {
    
    func scrollToTop(isAnimated: Bool) {
        var off = base.contentOffset
        off.y = 0 - base.contentInset.top
        base.setContentOffset(off, animated: isAnimated)
    }
    
    func scrollToLeft(isAnimated: Bool) {
        var off = base.contentOffset
        off.x = 0 - base.contentInset.left
        base.setContentOffset(off, animated: isAnimated)
    }
    
    func scrollToBottom(isAnimated: Bool) {
        var off = base.contentOffset
        off.y = base.contentSize.height - base.bounds.size.height + base.contentInset.bottom
        base.setContentOffset(off, animated: isAnimated)
    }
    
    func scrollToRight(isAnimated: Bool) {
        var off = base.contentOffset
        off.x = base.contentSize.width - base.bounds.width + base.contentInset.right
        base.setContentOffset(off, animated: isAnimated)
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
