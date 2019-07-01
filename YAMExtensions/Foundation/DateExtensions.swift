//
//  DateExtensions.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/10/24.
//  Copyright © 2018 compassic/YaM. All rights reserved.
//

import Foundation

extension Date {
    
    /// return date of year
    var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    /// return date of month
    var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    /// return date of day
    var day: Int {
        return Calendar.current.component(Calendar.Component.day, from: self)
    }
    
    /// return date of hour
    var hour: Int {
        return Calendar.current.component(Calendar.Component.hour, from: self)
    }
    
    /// return date of minute
    var minute: Int {
        return Calendar.current.component(Calendar.Component.minute, from: self)
    }
    
    /// return date of second
    var second: Int {
        return Calendar.current.component(Calendar.Component.second, from: self)
    }
    
    /// return date of nanosecond
    var nanosecond: Int {
        return Calendar.current.component(Calendar.Component.nanosecond, from: self)
    }
    
    /// return weekday(1~7)
    var weekday: Int {
        return Calendar.current.component(Calendar.Component.weekday, from: self)
    }
    
    /// return week of moneth(1~5)
    var weekOfMonth: Int {
        return Calendar.current.component(Calendar.Component.weekOfMonth, from: self)
    }
    
    /// return week of year(1~53)
    var weekOfYead: Int {
        return Calendar.current.component(Calendar.Component.weekOfYear, from: self)
    }
    
    var isToday: Bool {
        if fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24 {
            return false
        }
        return Date().day == self.day
    }
    
    /// return a formatter string representing this date
    func string(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
    
    /// return a date parsed from given string interpreted using the format
    func date(withString dateString: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
}
