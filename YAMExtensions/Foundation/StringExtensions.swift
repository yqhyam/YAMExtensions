//
//  String+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/3.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit
import CommonCrypto

extension String {
    
    static var stringWithUUID: String {
        let uuid = CFUUIDCreate(nil)
        let string = CFUUIDCreateString(nil, uuid)
        return string! as String
    }
    
    /**
     return a md5 string
     */
    func md5String() -> String{
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(Array(self.utf8), CC_LONG(self.count), result)
        let str = String(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                         result[0], result[1], result[2], result[3],
                         result[4], result[5], result[6], result[7],
                         result[8], result[9], result[10], result[11],
                         result[12], result[13], result[14], result[15])
        return str
    }
    
    /// returns the size of the string if it were rendered with the specified constraints
    func size(forFont font: UIFont, size: CGSize, lineBreakMode: NSLineBreakMode) -> CGSize {
        var result = CGSize.zero
        var attr: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        if lineBreakMode != NSLineBreakMode.byWordWrapping {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode
            attr[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        let rect = (self as NSString).boundingRect(with: size, options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], attributes: attr, context: nil)
        result = rect.size
        return result
    }
    
    /// return the width of the string
    func width(forFont font: UIFont) -> CGFloat {
        let size = self.size(forFont: font, size: CGSize(width: CGFloat(HUGE), height: CGFloat(HUGE)), lineBreakMode: NSLineBreakMode.byWordWrapping)
        return size.width
    }
    
    /// return the height of the string
    func height(forFont font: UIFont) -> CGFloat {
        let size = self.size(forFont: font, size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), lineBreakMode: NSLineBreakMode.byWordWrapping)
        return size.height
    }
    
    /// check if has blank
    func isNotBlank() -> Bool {
        let blank = CharacterSet.whitespacesAndNewlines
        for char in self {
            if char.unicodeScalars.contains(where: { blank.contains($0) }) {
                return false
            }
        }
        return true
    }
    
    /// return a Data using utf8 encoding
    func dataValue() -> Data? {
        return self.data(using: Encoding.utf8)
    }
    
    /// return range of all string
    func range() -> NSRange {
        return NSRange(location: 0, length: self.count)
    }
    
    /// return Dictionary/Array which is decoded from receiver
    func jsonValueDecoded() -> Any? {
        return self.dataValue()?.jsonValueDecoded()
    }
    
    /// return string from local .txt file
    func string(named name: String) -> String {
        var path = Bundle.main.path(forResource: name, ofType: "") ?? ""
        do {
            var str = try String(contentsOfFile: path, encoding: Encoding.utf8)
            path = Bundle.main.path(forResource: name, ofType: "txt") ?? ""
            str = try String(contentsOfFile: path, encoding: Encoding.utf8)
            return str
        } catch let error {
            print("string named error:", error)
        }
        return ""
    }
    
    // 验证手机号
    func validatePhono() -> Bool {
        //手机号以13,15,17,18开头，八个 \d 数字字符
        let phoneString = "^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneString)
        return phonePredicate.evaluate(with: self)
    }
    
    // 验证车牌
    func validateLicence() -> Bool {
        
        let phoneString = "^[\\u4e00-\\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneString)
        return phonePredicate.evaluate(with: self)
    }
    
    // 验证密码
    func validatePassword() -> Bool {
        
        let phoneString = "^[a-zA-Z0-9]{6,20}+$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneString)
        return phonePredicate.evaluate(with: self)
    }
    
    // 验证邮箱
    func validateEmail() -> Bool {
        
        let emailString = "[A-Z0-9a-z._% -] @[A-Za-z0-9.-] \\.[A-Za-z]{2,4}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailString)
        return emailPredicate.evaluate(with: self)
    }
    
    // 验证昵称
    func validateNickName() -> Bool {
        
        let emailString = "^(?!_)(?!.*?_$)[a-zA-Z0-9_\\u4e00-\\u9fa5]+$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailString)
        return emailPredicate.evaluate(with: self)
    }
    
    // 验证用户名
    func validateUserName() -> Bool {
        
        let string = "^[A-Za-z0-9]{6,20}+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", string)
        return predicate.evaluate(with: self)
    }
    
    // 验证纯数字
    func validateNumber() -> Bool {
        
        let string = "^[0-9]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", string)
        return predicate.evaluate(with: self)
    }
}
