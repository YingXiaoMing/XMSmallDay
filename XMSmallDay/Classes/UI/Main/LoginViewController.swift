//
//  LoginViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/19.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var backScrollView: UIScrollView!
    var topView: UIView!
    var phoneTextFile: UITextField!
    var pwdTextFile: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "登录"
        
        
        view.backgroundColor = theme.SDWebViewBackgroundColor
        //添加scrollView
        addScrollView()
        addTextFile()
    }
    func addScrollView() {
        backScrollView = UIScrollView(frame: view.bounds)
        backScrollView.backgroundColor = theme.SDWebViewBackgroundColor
        backScrollView.alwaysBounceVertical = true
        let  tap = UITapGestureRecognizer(target: self, action: "backScrollViewTap")
        backScrollView.addGestureRecognizer(tap)
        view.addSubview(backScrollView)
    }
    func backScrollViewTap() {
        view.endEditing(true)
    }
    func addTextFile() {
        let textH: CGFloat = 55
        let Margin: CGFloat = 10
        let alphaV: CGFloat = 0.2
        topView = UIView(frame: CGRectMake(0, 20, AppWidth, textH * 2))
        topView.backgroundColor = UIColor.whiteColor()
        backScrollView.addSubview(topView)
        
        let line1 = UIView(frame: CGRectMake(0, 0, AppWidth, 1))
        line1.backgroundColor = UIColor.grayColor()
        line1.alpha = alphaV
        topView.addSubview(line1)
        
        phoneTextFile = UITextField()
        phoneTextFile.keyboardType = UIKeyboardType.NumberPad
        addTextFileToTopView(phoneTextFile, frame: CGRectMake(Margin, 1, AppWidth - Margin, textH - 1), placeHolder: "请输入手机号")
        pwdTextFile = UITextField()
        let line2 = UIView(frame: CGRectMake(0, textH, AppWidth, 1))
        line2.backgroundColor = UIColor.grayColor()
        line2.alpha = alphaV
        
        pwdTextFile = UITextField()
        addTextFileToTopView(pwdTextFile, frame: CGRectMake(Margin, 1 + textH, AppWidth - Margin, textH - 1), placeHolder: "请输入密码")
        
        
    }
    func addTextFileToTopView(textFiled: UITextField, frame: CGRect, placeHolder: String)
    {
        textFiled.frame = frame
        textFiled.autocorrectionType = .No
        textFiled.clearButtonMode = .Always
        textFiled.backgroundColor = UIColor.whiteColor()
        textFiled.placeholder = placeHolder
        topView.addSubview(textFiled)
    }
    func addBottomView() {
        
    }
}
