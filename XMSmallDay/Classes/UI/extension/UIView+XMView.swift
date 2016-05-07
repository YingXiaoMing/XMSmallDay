//
//  UIView+XMView.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    var x : CGFloat {
        return self.frame.origin.x
    }
    var y : CGFloat {
        return self.frame.origin.y
    }
    var width : CGFloat {
        return self.frame.size.width
    }
    var height : CGFloat {
        return self.frame.size.height
    }
    var size : CGSize {
        return self.frame.size
    }
    var point : CGPoint {
        return self.frame.origin
    }
}