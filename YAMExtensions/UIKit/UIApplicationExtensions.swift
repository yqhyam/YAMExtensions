//
//  UIApplication+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/7.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /**
     'Documents' folder in app`s sandbox
     */
    var documentsURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }
    var documentsPath: String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }
    
    /**
     'Caches' folder in this app`s sandbox
     */
    var cachesURL: URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last
    }
    var cachesPath: String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    
    /**
     'Library' folder in this app`s sandbox
     */
    var libraryURL: URL? {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last
    }
    var libraryPath: String? {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
    }
    
    /**
     Application`s Bundle Name
     */
    var appBundleName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    /// Application`s Bundle ID e.g 'com.yamex.app'
    var appBundleID: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String
    }
    
    /// Application`s Bundle Version e.b '1.0.0'
    var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    /// Application`s Bundle Version e.b '12'
    var appBuildVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    
    /// Wether this app is not install from appstroe
    var isPirated: Bool {
        if UIDevice.current.isSimulator { return true }
        if getgid() <= 10 { return true } /// process ID shouldn't be root
        if (Bundle.main.infoDictionary!["SignerIdentity"] != nil) { return true }
        if yam_fileExistInMainBundle(name: "_CodeSignature") { return true }
        if yam_fileExistInMainBundle(name: "SC_Info") { return true }
        return false
    }
    
    fileprivate func yam_fileExistInMainBundle(name: String) -> Bool {
        let bundlePath = Bundle.main.bundlePath
        let path = String.init(format: "%@%@", bundlePath, name)
        return FileManager.default.fileExists(atPath: path)
    }
    
    /// Whether this app is being debugged
    var isBeingDebugged: Bool {
        var info = kinfo_proc()
        var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var size = MemoryLayout<kinfo_proc>.stride
        let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
        assert(junk == 0, "sysctl failed")
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }
    
    /// current thread real memory used in byte
    var memoryUsage: Float? {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout.size(ofValue: info) / MemoryLayout<integer_t>.size)
        let kerr = withUnsafeMutablePointer(to: &info) { infoPtr in
            return infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { (machPtr: UnsafeMutablePointer<integer_t>) in
                return task_info(
                    mach_task_self_,
                    task_flavor_t(MACH_TASK_BASIC_INFO),
                    machPtr,
                    &count
                )
            }
        }
        guard kerr == KERN_SUCCESS else {
            return nil
        }
        return Float(info.resident_size) / (1024 * 1024)
    }
    
    // YY原方法不是很准确，计算出来的CPU占用率会维持一个值基本没有变化。代码中的 _prevCPUInfo 和 _numPrevCPUInfo 等使用的是局部变量，这会造成对 _prevCPUInfo 非空的判断总是为假，最终计算 _cpuInfo 和 _prevCPUInfo 差值的那段代码根本不会执行。修改如下
    var cpuUsage: Float {
        let HOST_CPU_LOAD_INFO_COUNT = MemoryLayout<host_cpu_load_info>.stride/MemoryLayout<integer_t>.stride
        var size = mach_msg_type_number_t(HOST_CPU_LOAD_INFO_COUNT)
        var previous_info = host_cpu_load_info()
        var cpuLoadInfo = host_cpu_load_info()
        
        let result = withUnsafeMutablePointer(to: &cpuLoadInfo){
            $0.withMemoryRebound(to: integer_t.self, capacity: HOST_CPU_LOAD_INFO_COUNT){
                host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &size)
            }
        }
        
        if result != KERN_SUCCESS {
            return -1
        }
        
        let user = cpuLoadInfo.cpu_ticks.0 - previous_info.cpu_ticks.0
        let system = cpuLoadInfo.cpu_ticks.1 - previous_info.cpu_ticks.1
        let idle = cpuLoadInfo.cpu_ticks.2 - previous_info.cpu_ticks.2
        let nice = cpuLoadInfo.cpu_ticks.3 - previous_info.cpu_ticks.3
        let total = user + nice + idle + system
        previous_info = cpuLoadInfo
        return Float((user + nice + system) * 100 / total)
    }
}

