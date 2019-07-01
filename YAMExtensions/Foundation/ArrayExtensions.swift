//
//  ArrayExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/24.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import Foundation

extension Array {
    
    /// return a object located at a random index
    func random() -> Any? {
        if self.count > 0 {
            return self[Int(arc4random_uniform(UInt32(self.count)))]
        }
        return nil
    }
    
    func jsonStringEncoded() -> String {
        if JSONSerialization.isValidJSONObject(self) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
                let json = String(data: jsonData, encoding: .utf8)
                return json ?? ""
            } catch let error {
                print(error)
            }
        }
        return ""
    }
}
