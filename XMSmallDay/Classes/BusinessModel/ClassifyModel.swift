//
//  ClassifyModel.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/17.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class ClassifyModel: NSObject, DictModelProtocol {
    var code: Int = -1
    var list: [ClassModel]?
    static func customClassMapping() -> [String : String]? {
        return ["list": "\(ClassModel.self)"]
    }
    class func loadClassifyModel(completion: (data: ClassifyModel?, error: NSError?)->())
    {
        let path = NSBundle.mainBundle().pathForResource("Classify", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict : NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: ClassifyModel.self) as? ClassifyModel
            completion(data: data, error: nil)
        }
    }
}
class ClassModel: NSObject, DictModelProtocol {
    var title: String?
    var id: Int = -1
    var tags : [EveryClassModel]?
    static func customClassMapping() -> [String : String]? {
        return ["tags": "\(EveryClassModel.self)"]
    }
}
class EveryClassModel: NSObject {
    //分类详情个数
    var ev_count: Int = -1
    var id: Int = -1
    var img: String?
    var name: String?
}
class DetailModel: NSObject, DictModelProtocol {
    var msg: String?
    var code: Int = -1
    var list: [EventModel]?
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(EventModel.self)"]
    }
    private class func loadDatas(fileName: String, isShowDis: Bool, completion: (data: DetailModel?, error:NSError?) -> ()){
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: nil)
        if let data = NSData(contentsOfFile: path!) {
            let dict = (try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let datas = modelTool.objectWithDictionary(dict, cls: DetailModel.self) as? DetailModel
            if isShowDis {
                for event in datas!.list! {
                    event.isShowDis = true
                    
                }
            }
        }
    }
    
}


