//
//  DispatchTime.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/29.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import UIKit

extension DispatchQueue {
    func after(time: Double, block: @escaping () -> Void) {
        let dtime = DispatchTime.now() + time * Double(NSEC_PER_SEC) / Double(NSEC_PER_SEC)
        self.asyncAfter(deadline: dtime, execute: block)
    }
}
