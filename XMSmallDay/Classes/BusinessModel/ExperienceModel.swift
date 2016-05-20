//
//  ExperienceModel.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/20.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class ExperienceModel: NSObject, DictModelProtocol {
    var head: [ExperienceHeadModel]?
    var list: [EventModel]?
    static func customClassMapping() -> [String : String]? {
        return ["head": "\(ExperienceHeadModel.self)", "list": "\(EventModel.self)"]
    }
    class func loadExperienceModel(completition: (data: ExperienceModel?, error: NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("Experience", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: ExperienceModel.self) as? ExperienceModel
            completition(data: data, error: nil)
        }
    }  
}
class ExperienceHeadModel: NSObject {
    var feel: String?
    var shareURL: String?
    var tag: String?
    var id: Int = -1
    var adurl: String?
    var title: String?
    var mobileURL: String?
}