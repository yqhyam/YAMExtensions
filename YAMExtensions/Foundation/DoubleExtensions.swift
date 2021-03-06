//
//  DoubleExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2021/2/23.
//  Copyright © 2021 compassic/YaM. All rights reserved.
//

import Foundation

extension Double {
    ///四舍五入 到小数点后某一位
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    ///截断 到小数点后某一位
    func truncate(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Double(Int(self * divisor)) / divisor
    }
}
