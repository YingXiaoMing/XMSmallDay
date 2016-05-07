//
//  UIBarButtonItem+XMBarButtonItem.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import Foundation
import UIKit
extension UIBarButtonItem{
    //纯文字导航栏标题
    convenience init(title: String, titleColor: UIColor, target: AnyObject, action: Selector){
        let button = UIButton(type: .Custom)
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(titleColor, forState: .Normal)
        button.titleLabel?.font = theme.SDNavItemFont
        button.frame = CGRectMake(0, 0, 60, 44)
        button.titleLabel?.textAlignment = NSTextAlignment.Right
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5)
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        self.init(customView: button)
    }
    //导航栏右边按钮的自定义item
    convenience init(imageName: String, hightImageName: String, target: AnyObject, action: Selector) {
        let button : UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: hightImageName), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 50, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        self.init(customView: button)
    }
    //导航栏右边按钮的选中状态的自定义item
    convenience init(imageName: String, highImageName: String, selectedImage: String, target: AnyObject, action: Selector){
        let button : UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: highImageName), forState: .Highlighted)
        button.setImage(UIImage(named: selectedImage), forState: .Selected)
        button.frame = CGRectMake(0, 0, 50, 44)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        self.init(customView: button)
    }
    //导航栏左边按钮的自定义item
    convenience init(leftImageName: String, highImageName: String, target: AnyObject, action: Selector){
        let button : UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: leftImageName), forState: .Normal)
        button.setImage(UIImage(named: highImageName), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 80, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        self.init(customView: button)
    }
    
    
}