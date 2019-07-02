//
//  UITextField+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/2.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

extension UITextField {
    
    func selectAllText() {
        let range = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument)
        self.selectedTextRange = range
    }
    
    func setSelected(range: NSRange) {
        let beginning = self.beginningOfDocument
        let startPosition = self.position(from: beginning, offset: range.location)
        let endPosition = self.position(from: beginning, offset: NSMaxRange(range))
        let selectionRange = self.textRange(from: startPosition!, to: endPosition!)
        self.selectedTextRange = selectionRange
    }
}
