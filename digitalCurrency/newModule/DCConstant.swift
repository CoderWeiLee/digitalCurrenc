//
//  DCGrobalConstants.swift
//  digitalCurrenc
//
//  Created by Munger Yu on 2021/1/5.
//

import UIKit
@_exported import SwiftyJSON

@objcMembers public class DCConstant: NSObject {
    static let appWidth: CGFloat = UIScreen.main.bounds.width
    static let appHeight: CGFloat = UIScreen.main.bounds.height
    static let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first ?? UIApplication.shared.windows[0]
    
    static let appStatusBarHeight: CGFloat =  UIApplication.shared.statusBarFrame.height
    static let appNavBarHeight: CGFloat = DCConstant.appStatusBarHeight + 44

    static let appSafeBottom: CGFloat = {
        if #available(iOS 11.0, *) {
            return keyWindow.safeAreaInsets.bottom
        } else {
            return 0
        }
    }()
    
    static let appSafeTop: CGFloat =  {
        if #available(iOS 11.0, *) {
            return keyWindow.safeAreaInsets.top
        } else {
            return 0
        }
    }()
    
    static let appTabBarHeight: CGFloat = {
        if #available(iOS 11.0, *) {
            return keyWindow.safeAreaInsets.bottom + 49
        } else {
            return 0
        }
    }()
}


func printLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    let date = Date().addingTimeInterval(TimeInterval(NSTimeZone.system.secondsFromGMT()))
    print("----->\(date) \((file as NSString).lastPathComponent): \(line) \(method): \(message)")
}
