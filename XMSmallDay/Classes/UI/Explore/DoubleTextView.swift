//
//  DoubleTextView.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class DoubleTextView: UIView {
    private let leftTextButton: NoHighlightButton = NoHighlightButton()
    private let rightTextButton: NoHighlightButton = NoHighlightButton()
    private let textColorNormal: UIColor = UIColor(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1)
    private let bottomLineView: UIView = UIView()
    private var selectedBtn: UIButton?
    private let textFont: UIFont = theme.SDNavItemFont
    convenience init(leftText: String, rightText: String){
        self.init()
        //设置左边文字
        setButton(leftTextButton, title: leftText, tag: 100)
        //设置右边文字
        setButton(rightTextButton, title: rightText, tag: 101)
        setBottomLine()
        
    }
    private func setBottomLine(){
        bottomLineView.backgroundColor = UIColor(red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1)
        addSubview(bottomLineView)
    }
    private func setButton(button: UIButton, title: String, tag: Int){
        button.setTitleColor(UIColor.blackColor(), forState: .Selected)
        button.setTitleColor(textColorNormal, forState: .Normal)
        button.titleLabel?.font = textFont
        button.setTitle(title, forState: .Normal)
        button.tag = tag
        button.addTarget(self, action:"titleBtnClick:" , forControlEvents: .TouchUpInside)
        addSubview(button)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let btnW = width * 0.5
        rightTextButton.frame = CGRectMake(btnW, 0, btnW, height)
        leftTextButton.frame = CGRectMake(0, 0, btnW, height)
        bottomLineView.frame = CGRectMake(0, height - 2, btnW, 2)
    }
    func titleBtnClick(sender: UIButton){
        //选中三部曲
        selectedBtn?.selected = false
        sender.selected = true
        selectedBtn = sender
        bottomLineScrollTo(sender.tag - 100)
        
    }
    func bottomLineScrollTo(index: Int){
        UIView.animateWithDuration(0.2) { () -> Void in
            self.bottomLineView.frame.origin.x = CGFloat(index) * self.bottomLineView.width
        }
    }
}



class NoHighlightButton: UIButton {
    override var highlighted: Bool {
        didSet{
            super.highlighted = false
        }
    }
}