//
//  UITextField+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/2.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

extension YamEx where Base: TextField {
    
    func selectAllText() {
        let range = base.textRange(from: base.beginningOfDocument, to: base.endOfDocument)
        base.selectedTextRange = range
    }
    
    func setSelected(range: NSRange) {
        let beginning = base.beginningOfDocument
        let startPosition = base.position(from: beginning, offset: range.location)
        let endPosition = base.position(from: beginning, offset: NSMaxRange(range))
        let selectionRange = base.textRange(from: startPosition!, to: endPosition!)
        base.selectedTextRange = selectionRange
    }
}
