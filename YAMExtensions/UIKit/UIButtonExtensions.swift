//
//  UIButtonExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/29.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import UIKit

struct AssociatedKeys {
    static var clickAreaKey: String = "testNameKey"
}

extension UIButton{
    
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
         
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
         
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
     
    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode,
        spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
         
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
         
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    
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
    
    /// 点击范围
    var clickArea: String? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.clickAreaKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.clickAreaKey) as? String
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        
        var bounds = self.bounds
        if let area = self.clickArea?.toFloat {
            let scale = CGFloat(area)
            let w = max(scale * bounds.width, 0)
            let h = max(scale * bounds.height, 0)
            bounds = bounds.insetBy(dx: -0.5 * w, dy: -0.5 * h)
        }
        
        return bounds.contains(point)
    }
}
