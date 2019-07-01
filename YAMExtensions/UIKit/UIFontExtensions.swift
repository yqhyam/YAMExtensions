//
//  UIFont+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/10.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

extension YamEx where Base: Font {
    
    /// check if font is bold
    var isBold: Bool {
        return base.fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    /// check if font is italic
    var isItalic: Bool {
        return base.fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    /// check if font is monoSpace
    var isMonoSpace: Bool {
        return base.fontDescriptor.symbolicTraits.contains(.traitMonoSpace)
    }
    
    /// create a bold and italic font
    class func boldWithItalicFont(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Arial-BoldItalicMT", size: ofSize)!
    }
    
    /// change the font to bold and italic
    func toBoldItalic() -> UIFont {
        return UIFont(descriptor: base.fontDescriptor.withSymbolicTraits([UIFontDescriptorSymbolicTraits.traitBold, UIFontDescriptorSymbolicTraits.traitItalic])!, size: base.pointSize)
    }
    
    /// change the font to bold
    func toBold() -> UIFont {
        return UIFont(descriptor: base.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits.traitBold)!, size: base.pointSize)
    }
    
    /// change the font to italic
    func toItalic() -> UIFont {
        return UIFont(descriptor: base.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits.traitItalic)!, size: base.pointSize)
    }
    
    /// change the font to system font
    func toSystem() -> UIFont {
        return UIFont.systemFont(ofSize: base.pointSize)
    }
    
    /// return a font object for the specified CTFontRef
    class func fontWith(CTFont: CTFont) -> UIFont? {
        let name = CTFontCopyPostScriptName(CTFont) as String
        let size = CTFontGetSize(CTFont)
        let font = Base(name: name, size: size)
        return font
    }
    
    /// return a font object for the specified CGFont
    class func fontWith(cgFont: CGFont, size: CGFloat) -> UIFont? {
        guard let name = cgFont.postScriptName as String? else { return nil }
        let font = Base(name: name, size: size)
        return font
        
    }
    
    /// create the CTFont object
    func toCTFont() -> CTFont {
        let font = CTFontCreateWithName(base.fontName as CFString, base.pointSize, nil)
        return font
    }
    
    /// create the CGFont object
    func toCGFont() -> CGFont? {
        let font = CGFont(base.fontName as CFString)
        return font
    }
}
