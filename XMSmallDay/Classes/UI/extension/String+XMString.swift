//
//  String+XMString.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/21.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import Foundation

extension String {
    //判断是否是邮箱
    func validateEmail() ->Bool {
        let emailRgex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailText: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRgex)
        return emailText.evaluateWithObject(self)
    }
    //判断是否是手机号
    func validateMobile() ->Bool{
        let phoneRgex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRgex)
        return phoneText.evaluateWithObject(self)
    }
}
extension NSMutableString {
    class func changeHeightAndWidthWithString(searchStr: NSMutableString) -> NSMutableString {
        var mut = [CGFloat]()
        var mutH = [CGFloat]()
        let imageW = AppWidth - 23
        let rxHeight = NSRegularExpression(pattern: "(?<= height=\")\\d*")
        let rxWidth = NSRegularExpression(pattern: "(?<=width=\")\\d*")
        let widthArray = rxWidth.matches(searchStr as String) as! [String]
        for width in widthArray {
            Int(width)!
            mut.append(imageW/CGFloat(Int(width)!))
        }
        var widthMatches = rxWidth.matchesInString(searchStr as String, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, searchStr.length))
        
        for var i = widthMatches.count - 1; i >= 0; i-- {
            let widthMatch = widthMatches[i] as NSTextCheckingResult
            searchStr.replaceCharactersInRange(widthMatch.range, withString: "\(imageW)")
        }
        
        let newString = searchStr.mutableCopy() as! NSMutableString
        
        let heightArray = rxHeight.matches(newString as String) as! [String]
        for i in 0..<mut.count {
            mutH.append(mut[i] * CGFloat(Int(heightArray[i])!))
        }
        
        var matches = rxHeight.matchesInString(newString as String, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, newString.length))
        
        for var i = matches.count - 1; i >= 0; i--
        {
            let match = matches[i] as NSTextCheckingResult
            newString.replaceCharactersInRange(match.range, withString: "\(mutH[i])")
        }
        
        return newString
    }
}