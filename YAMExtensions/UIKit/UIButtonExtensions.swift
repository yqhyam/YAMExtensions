//
//  UIButtonExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/29.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import UIKit

extension UIButton{
    
    func setViews() {
        guard let imageSize = self.imageView?.frame.size, var titleSize = self.titleLabel?.frame.size  else {
            return
        }
        
        let space: CGFloat = 5
        let text = self.titleLabel?.text
        let textSize = text?.size(forFont: self.titleLabel!.font, size: CGSize(width: CGFloat(HUGE), height: CGFloat(HUGE)), lineBreakMode: NSLineBreakMode.byWordWrapping)
        let frameSize = CGSize(width: CGFloat(ceilf(Float(textSize?.width ?? 0))), height: CGFloat(ceilf(Float(textSize?.height ?? 0))));
        if titleSize.width + 0.5 < frameSize.width {
            titleSize.width = frameSize.width
        }
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -imageSize.height - space, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: -titleSize.height - space, left: 0, bottom: 0, right: -titleSize.width)
    }
}
