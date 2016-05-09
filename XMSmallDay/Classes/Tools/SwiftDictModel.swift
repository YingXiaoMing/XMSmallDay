//
//  SwiftDictModel.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/9.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import Foundation


public class DictModelManager {
    private static let instance = DictModelManager()
    public class var sharedManager: DictModelManager{
        return instance
    }
    //字典转模型
    public func objectWithDictionary(dict: NSDictionary, cls: AnyObject) -> AnyObject? {
        //动态获取命名空间
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExectutable"] as! String
        //模型信息
        
    }
    //加载完整类信息
    func fullModelInfo(cls: AnyObject) -> [String: String]{
        //检测缓冲池
        if let cache = modelCache["\(cls)"]{
            return cache
        }
        var currentCls : AnyObject = cls
        var infoDict = [String: String]()
        var let parent: AnyClass = currentCls.superclass() {
            
        }
        
        
    }
    //加载类信息
    func modelInfo(cls: AnyClass) -> [String: String]{
        if let cache = modelCache["\(cls)"]{
            return cache
        }
        //拷贝属性列表
        var count: UInt32 = 0
        let properties = class_copyPropertyList(cls, &count)
        //检查类是否实现了协议
        var mappingDict: [String: String]?
        if cls.respondsToSelector("customClassMapping"){
        }
        
    }

    //模型缓冲
    var modelCache = [String: [String: String]]()
}





extension Dictionary {
   
    mutating func merge<K, V>(dict: [K: V]){
        for (k, v)in dict{
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
}
