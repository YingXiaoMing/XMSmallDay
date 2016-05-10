//
//  EveryDayModel.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/9.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit
//美天
class EveryDays: NSObject, DictModelProtocol {
    var msg: String?
    var code: Int = -1
    var list: [EveryDay]?
    class func loadEventsData(comletion: (data: EveryDays?, error: NSError?)->()){
        let path = NSBundle.mainBundle().pathForResource("events", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: EveryDays.self) as? EveryDays
            comletion(data: data, error: nil)
        }
    }
    static func customClassMapping() -> [String : String]? {
        return ["list": "\(EveryDay.self)"]
    }
}
//美编
class ThemeModels: NSObject, DictModelProtocol {
    var lastdate: String?
    var list: [ThemeModel]?
    class func loadThemesData(comletion: (data: ThemeModel?, error: NSError?)->()) {
        let path = NSBundle.mainBundle().pathForResource("themes", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict : NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: ThemeModel.self) as? ThemeModel
            comletion(data: data, error: nil)
        }
    }
    static func customClassMapping() -> [String : String]? {
        return ["list":"\(ThemeModel.self)"]
    }
    
}
//美天model
class EveryDay: NSObject, DictModelProtocol {
    var date: NSString? {
        willSet {
            if let tmpDate = newValue {
                if tmpDate.length == 10{
                    if let tmpM = Int(tmpDate.substringWithRange(NSRange(location: 5, length: 2))){
                        switch tmpM {
                        case 1:
                            self.month = "Jan."
                        case 2:
                            self.month = "Feb."
                        case 3:
                            self.month = "Mar."
                        case 4:
                            self.month = "Apr."
                        case 5:
                            self.month = "May."
                        case 6:
                            self.month = "Jun."
                        case 7:
                            self.month = "Jul."
                        case 8:
                            self.month = "Aug."
                        case 9:
                            self.month = "Sep."
                        case 10:
                            self.month = "Oct."
                        case 11:
                            self.month = "Nov."
                        case 12:
                            self.month = "Dec."
                        default:
                            self.month = "\(tmpM)."
                        }
                    }else {
                        self.month = "Aug."
                    }
                    self.day = tmpDate.substringWithRange(NSRange(location: 8, length: 2))
                }else {
                    self.date = newValue
                    return
                }
            }
            self.date = newValue
        }
    }
    var themes: [ThemeModel]?
    var events: [EventModel]?
    var month: String?
    var day: String?
    static func customClassMapping() -> [String : String]? {
        return ["themes":"\(ThemeModel.self)","event":"\(EventModel.self)"]
    }
}
//美编model
class ThemeModel: NSObject {
    var themeurl: String?
    var img: String?
    var title: String?
    var hasweb: Int = -1
    var keywords: String?
    var id: Int = -1
    var text: String?
}
class GuessLikeModel: NSObject {
    //标题
    var title: String?
    //图片数组
    var imgs: [String]?
    //地址
    var adress: String?
}
//美天model
class EventModel: NSObject,DictModelProtocol {
    var feel: String?
    var shareURL: String?
    var note: String?
    var questionURL: String?
    var telephone: String?
    var tag: String?
    var id: Int = -1
    var title: String?
    var detail: String?
    var feeltitle: String?
    var city: String?
    var address: String?
    var remark: String?
    //顶部的图片数组
    var imgs: [String]?
    var more: [GuessLikeModel]?
    var mobileURL: String?
    var position: String?
    var isShowDis = false
    //当前用户距离我店铺的距离,单位为km
    var distanceForUser : String?
    static func customClassMapping() -> [String : String]? {
        return ["more" : "\(GuessLikeModel.self)"]
    }
}
