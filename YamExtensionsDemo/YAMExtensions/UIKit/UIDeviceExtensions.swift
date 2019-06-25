//
//  UIDevice+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/3.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

extension YamEx where Base: Device {
    
    var machineModel: String {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        let model = String(cString: machine)
        return model
    }
    
    class var systemVersion: Double {
        let version = Double(UIDevice.current.systemVersion)
        return version ?? 0.0
    }
    
    var isPad: Bool {
        let isPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
        return isPad
    }
    
    var isSimulator: Bool {
        #if TARGET_OS_SIMULATOR
        return true
        #else
        return false
        #endif
    }
    
    var isJailbroken: Bool {
        if self.isSimulator { return false }
        
        let paths = ["/Applications/Cydia.app",
                     "/pravate/var/lib/apt/",
                     "/private/var/lib/cydia",
                     "/private/var/stash"]
        for path in paths {
            if FileManager.default.fileExists(atPath: path) { return true }
        }
        
        let bash = fopen("/bin/bash", "r")
        if bash != nil {
            fclose(bash)
            return true
        }
        
        let path = String.localizedStringWithFormat("/private/%@", String.stringWithUUID)
        do {
            try "test".write(toFile: path, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch  {
            print(error)
        }
        return false
    }
    
    #if __IPHONE_OS_VERSION_MIN_REQUIRED
    var canMakePhoneCalls: Bool {
        return UIApplication.shared.canOpenURL(URL(string: "tel://")!)
    }
    #endif
    
    fileprivate func ipAddress(with ifaName: String) -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == ifaName {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
    
    /**
     get WIFI Addess IP of this device
     */
    var ipAddressWIFI: String? {
        return ipAddress(with: "en0")
    }
    
    /**
     get cell Adress IP of this device
     */
    var ipAddressCell: String? {
        return ipAddress(with: "pdp_ip0")
    }
    
    struct yam_net_interface_counter {
        let en_in: __uint64_t
        let en_out: __uint64_t
        let pdp_ip_in: __uint64_t
        let pdp_ip_out: __uint64_t
        let awdl_in: __uint64_t
        let awdl_out: __uint64_t
    }
    
    static func yy_new_counter_add(counter: __uint64_t, bytes: __uint64_t) -> __uint64_t {
        var count = counter
        if bytes < (counter % 0xFFFFFFFF) {
            count += 0xFFFFFFFF - (count % 0xFFFFFFFF)
            count += bytes
        }
        else {
            count = bytes
        }
        return count
    }
    
    
}
