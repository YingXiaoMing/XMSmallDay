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