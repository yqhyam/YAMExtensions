//
//  UIFont+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/10.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

extension UIFont {
    
    /// check if font is bold
    var isBold: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    /// check if font is italic
    var isItalic: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    /// check if font is monoSpace
    var isMonoSpace: Bool {
        return self.fontDescriptor.symbolicTraits.contains(.traitMonoSpace)
    }
    
    /// create a bold and italic font
    class func boldWithItalicFont(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Arial-BoldItalicMT", size: ofSize)!
    }
    
    /// change the font to bold and italic
    func toBoldItalic() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits([UIFontDescriptor.SymbolicTraits.traitBold, UIFontDescriptor.SymbolicTraits.traitItalic])!, size: self.pointSize)
    }
    
    /// change the font to bold
    func toBold() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)!, size: self.pointSize)
    }
    
    /// change the font to italic
    func toItalic() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitItalic)!, size: self.pointSize)
    }
    
    /// change the font to system font
    func toSystem() -> UIFont {
        return UIFont.systemFont(ofSize: self.pointSize)
    }
    
    /// return a font object for the specified CTFontRef
    class func fontWith(CTFont: CTFont) -> UIFont? {
        let name = CTFontCopyPostScriptName(CTFont) as String
        let size = CTFontGetSize(CTFont)
        let font = self.init(name: name, size: size)
        return font
    }
    
    /// return a font object for the specified CGFont
    class func fontWith(cgFont: CGFont, size: CGFloat) -> UIFont? {
        guard let name = cgFont.postScriptName as String? else { return nil }
        let font = self.init(name: name, size: size)
        return font
        
    }
    
    /// create the CTFont object
    func toCTFont() -> CTFont {
        let font = CTFontCreateWithName(self.fontName as CFString, self.pointSize, nil)
        return font
    }
    
    /// create the CGFont object
    func toCGFont() -> CGFont? {
        let font = CGFont(self.fontName as CFString)
        return font
    }
}
