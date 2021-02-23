//
//  DictionaryExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/25.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import Foundation

extension Dictionary {
    
    ///  Convert dictionary to json string. return nil if an error occurs
    func toJSON() -> String {
        if JSONSerialization.isValidJSONObject(self) {
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
                let json = String(data: jsonData, encoding: .utf8)
                return json ?? ""
            } catch let error {
                print("jsonStringEncoded:", error)
            }
        }
        return ""
    }
    
}
