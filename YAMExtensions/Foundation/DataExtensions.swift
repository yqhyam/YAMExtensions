//
//  DataExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/24.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import Foundation

extension Data {
    
    func utf8String() -> String {
        if self.count > 0 {
            return String(data: self, encoding: .utf8) ?? ""
        }
        return ""
    }
    
    func jsonValueDecoded() -> Any? {
        do {
            let value = try JSONSerialization.jsonObject(with: self, options: .allowFragments)
            return value
        } catch let error {
            print("jsonValueDecoded error:%@", error)
        }
        return nil
    }
}
