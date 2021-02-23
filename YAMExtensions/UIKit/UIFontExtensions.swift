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
    
    /// 中等
    public static func pingfangSC_medium(ofSize size: CGFloat) -> UIFont {
        return normalFont(size, "PingFangSC-Medium")
    }

    /// 常规
    public static func pingfangSC_regular(ofSize size: CGFloat) -> UIFont {
        return normalFont(size, "PingFangSC-Regular")
    }
    
    /// 细
    public static func pingfangSC_light(ofSize size: CGFloat) -> UIFont {
        return normalFont(size, "PingFangSC-Light")
    }
    
    /// 半黑体
    public static func pingfangSC_semibold(ofSize size: CGFloat) -> UIFont {
        return normalFont(size, "PingFangSC-Semibold")
    }
    
    /// 半黑体
    public static func notoSansHans(ofSize size: CGFloat) -> UIFont {
        return normalFont(size, "NotoSansMyanmar-Bold")
    }
    
    public static func normalFont(_ size: CGFloat, _ name: String) -> UIFont {
        guard name.length > 0 else {
            return UIFont.systemFont(ofSize: size)
        }
        return UIFont.init(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
