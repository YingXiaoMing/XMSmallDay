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
    var loginImageView: UIImageView!
    var quickLoginBtn: UIButton!
    let loginW: CGFloat = 250
    let textColor: UIColor = UIColor.colorWith(50, green: 50, blue: 50, alpha: 1)
    var bottomView: UIView!
    var forgetPwdImageView: UIImageView!
    var registerImageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "登录"
        view.backgroundColor = theme.SDWebViewBackgroundColor
//        添加scrollView
        addScrollView()
        addTextFile()
        addLoginImageView()
        addQucikLoginBtn()
        addBottomView()
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
        topView.addSubview(line2)
        pwdTextFile = UITextField()
        addTextFileToTopView(pwdTextFile, frame: CGRectMake(Margin, 1 + textH, AppWidth - Margin, textH - 1), placeHolder: "请输入密码")
    }
    func addLoginImageView() {
        let loginH: CGFloat = 50
        loginImageView = UIImageView(frame: CGRectMake((AppWidth - loginW) * 0.5, CGRectGetMaxY(topView.frame) + 20, loginW, loginH))
        loginImageView.userInteractionEnabled = true
        loginImageView.image = UIImage(named: "signin_1")
        backScrollView.addSubview(loginImageView)
        let loginLabel = UILabel(frame: loginImageView.bounds)
        loginLabel.text = "登  录"
        loginLabel.textAlignment = .Center
        loginLabel.font = UIFont.systemFontOfSize(22)
        loginImageView.addSubview(loginLabel)
        let tap = UITapGestureRecognizer(target: self, action: "loginClick")
        loginImageView.addGestureRecognizer(tap)
    }
    func addQucikLoginBtn() {
        quickLoginBtn = UIButton()
        quickLoginBtn.setTitle("无账号快捷登录", forState: .Normal)
        quickLoginBtn.titleLabel?.sizeToFit()
        quickLoginBtn.contentMode = .Right
        let quickW: CGFloat = quickLoginBtn.titleLabel!.width
        quickLoginBtn.frame = CGRectMake(AppWidth - quickW - 10, CGRectGetMaxY(loginImageView.frame) + 10, quickW, 30)
        quickLoginBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        quickLoginBtn.addTarget(self, action: "quickLoginClick", forControlEvents: .TouchUpInside)
        quickLoginBtn.setTitleColor(textColor, forState: .Normal)
        quickLoginBtn.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        backScrollView.addSubview(quickLoginBtn)
    }
    func addBottomView() {
        let bottomViewHeight: CGFloat = 45
        bottomView = UIView(frame: CGRectMake((AppWidth - loginW) * 0.5, AppHeight - 64 - 10 - bottomViewHeight, loginW, bottomViewHeight))
        bottomView.backgroundColor = UIColor.clearColor()
        backScrollView.addSubview(bottomView)
        forgetPwdImageView = UIImageView()
        addBottomViewWithImageView(forgetPwdImageView, tag: 10, frame: CGRectMake(0, 0, loginW * 0.5, bottomViewHeight), imageName: "c1_1", title: "忘记密码")
        registerImageView = UIImageView()
        addBottomViewWithImageView(registerImageView, tag: 11, frame: CGRectMake(loginW * 0.5, 0, loginW * 0.5, bottomViewHeight), imageName: "c1_2", title: "注册")
    }
    
    
    func loginClick() {
        if phoneTextFile.text!.validateMobile(){
            SVProgressHUD.showErrorWithStatus("请输入11位的正确手机号", maskType: .Black)
            return
        }else if pwdTextFile.text!.isEmpty {
            SVProgressHUD.showErrorWithStatus("密码不能为空", maskType: .Black)
            return
        }
        
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
    func addBottomViewWithImageView(imageView: UIImageView,tag: Int, frame: CGRect, imageName: String, title: String) {
        imageView.frame = frame
        imageView.image = UIImage(named: imageName)
        imageView.tag = tag
        imageView.userInteractionEnabled = true
        let label = UILabel(frame: CGRectMake(0, 0, imageView.width, imageView.height))
        label.textAlignment = .Center
        label.text = title
        label.font = UIFont.systemFontOfSize(15)
        imageView.addSubview(label)
        let tap = UITapGestureRecognizer(target: self, action: "bottomViewClick:")
        imageView.addGestureRecognizer(tap)
        bottomView.addSubview(imageView)
    }
    func bottomViewClick(tap: UITapGestureRecognizer){
        if tap.view?.tag == 10 {
            print("忘记密码")
        } else {
            print("注册")
            SVProgressHUD.showErrorWithStatus("直接登录,没有注册功能", maskType: .Black)
        }
    }
}
