//
//  NSObjectExt.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/06/17.
//

import Foundation
extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return self.className
    }
}
