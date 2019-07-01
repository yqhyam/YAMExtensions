//
//  UIButtonExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/29.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import UIKit

extension YamEx where Base: Button {
    
    func setViews() {
        guard let imageSize = base.imageView?.frame.size, var titleSize = base.titleLabel?.frame.size  else {
            return
        }
        
        let space: CGFloat = 5
        let text = base.titleLabel?.text
        let textSize = text?.size(forFont: base.titleLabel!.font, size: CGSize(width: CGFloat(HUGE), height: CGFloat(HUGE)), lineBreakMode: NSLineBreakMode.byWordWrapping)
        let frameSize = CGSize(width: CGFloat(ceilf(Float(textSize?.width ?? 0))), height: CGFloat(ceilf(Float(textSize?.height ?? 0))));
        if titleSize.width + 0.5 < frameSize.width {
            titleSize.width = frameSize.width
        }
        base.imageEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -imageSize.height - space, 0)
        base.titleEdgeInsets = UIEdgeInsetsMake(-titleSize.height - space, 0, 0, -titleSize.width)
    }
}
