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
    
    /// 计算年龄
    func ageWithBirthday() -> String {
        
        let com1 = Calendar.current.dateComponents([.day, .month, .year], from: self)
        let year = com1.year ?? 0
        let month = com1.month ?? 0
        let day = com1.day ?? 0
        
        let com2 = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        let currentYear = com2.year ?? 0
        let currentMonth = com2.month ?? 0
        let currentDay = com2.day ?? 0
        
        var _age = currentYear - year - 1
        if (currentMonth > month) || (currentMonth == month && currentDay >= day) {
            _age += 1
        }
        return "\(_age)"
    }
    
    /// 计算星座
    func calculateWithDate() -> String {
        guard let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) else {
            return ""
        }
        let components = calendar.components([.month, .day], from: self)
        let month = components.month!
        let day = components.day!
        
        // 月以100倍之月作为一个数字计算出来
        let mmdd = month * 100 + day;
        var result = ""
        
        if ((mmdd >= 321 && mmdd <= 331) ||
            (mmdd >= 401 && mmdd <= 419)) {
            result = "白羊座"
        } else if ((mmdd >= 420 && mmdd <= 430) ||
            (mmdd >= 501 && mmdd <= 520)) {
            result = "金牛座"
        } else if ((mmdd >= 521 && mmdd <= 531) ||
            (mmdd >= 601 && mmdd <= 621)) {
            result = "双子座"
        } else if ((mmdd >= 622 && mmdd <= 630) ||
            (mmdd >= 701 && mmdd <= 722)) {
            result = "巨蟹座"
        } else if ((mmdd >= 723 && mmdd <= 731) ||
            (mmdd >= 801 && mmdd <= 822)) {
            result = "狮子座"
        } else if ((mmdd >= 823 && mmdd <= 831) ||
            (mmdd >= 901 && mmdd <= 922)) {
            result = "处女座"
        } else if ((mmdd >= 923 && mmdd <= 930) ||
            (mmdd >= 1001 && mmdd <= 1023)) {
            result = "天秤座"
        } else if ((mmdd >= 1024 && mmdd <= 1031) ||
            (mmdd >= 1101 && mmdd <= 1122)) {
            result = "天蝎座"
        } else if ((mmdd >= 1123 && mmdd <= 1130) ||
            (mmdd >= 1201 && mmdd <= 1221)) {
            result = "射手座"
        } else if ((mmdd >= 1222 && mmdd <= 1231) ||
            (mmdd >= 101 && mmdd <= 119)) {
            result = "摩羯座"
        } else if ((mmdd >= 120 && mmdd <= 131) ||
            (mmdd >= 201 && mmdd <= 218)) {
            result = "水瓶座"
        } else if ((mmdd >= 219 && mmdd <= 229) ||
            (mmdd >= 301 && mmdd <= 320)) {
            //考虑到2月闰年有29天的
            result = "双鱼座"
        }else{
            print(mmdd)
            result = "日期错误"
        }
        return result
    }
}
