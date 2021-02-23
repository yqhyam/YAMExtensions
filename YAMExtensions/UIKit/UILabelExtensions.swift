//
//  UILabelExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2021/2/23.
//  Copyright © 2021 compassic/YaM. All rights reserved.
//

import UIKit

extension UILabel {
    
    func copyText() {
        guard let text = self.text, text.count > 0 else { return }
        let paster = UIPasteboard.general
        paster.string = text
    }

}
