//
//  EveryDayModel.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/9.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class EveryDays: NSObject {
    var msg: String?
    var code: Int = -1
    var list: [EveryDay]?
    class func loadEventsData(comletion: (data: EveryDays?, error: NSError?)->()){
        let path = NSBundle.mainBundle().pathForResource("events", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        
    }
}
class EveryDay: NSObject {
    
}