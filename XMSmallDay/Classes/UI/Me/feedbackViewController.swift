//
//  feedbackViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/21.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class feedbackViewController: UIViewController, UITextFieldDelegate {
    var feedbackTextView: UITextView!
    var contactTextView: UITextField!
    
    override func viewDidLoad() {
        //设置导航条的内容
        setNav()
        view.backgroundColor = theme.SDWebViewBackgroundColor
        setFeedbackTextViewAndContactTextFile()
    }
    private func setNav(){
        self.navigationItem.title = "留言反馈"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", titleColor: UIColor.blackColor(), target: self, action: "sendClick")
        
    }
    func sendClick(){
        let contactStr = contactTextView.text
        var alertView: UIAlertView?
        if feedbackTextView.text.isEmpty {
            alertView = UIAlertView(title: "提示", message: "请填写你的留言反馈", delegate: nil, cancelButtonTitle: "确定")
            alertView?.show()
            return
        }
        if contactStr!.validateEmail() || contactStr!.validateMobile() {
            alertView = UIAlertView(title: "提示", message: "感谢你的反馈", delegate: nil, cancelButtonTitle: "确定")
            alertView?.show()
            self.navigationController?.popToRootViewControllerAnimated(true)
        }else{
            alertView = UIAlertView(title: "提示", message: "请输入正确的手机号码或者邮箱", delegate: nil, cancelButtonTitle: "确定")
            alertView?.show()
        }
    }
    private func setFeedbackTextViewAndContactTextFile() {
        let backView = UIView(frame: CGRectMake(0, 5, AppWidth, 240))
        backView.backgroundColor = theme.SDBackgroundColor
        feedbackTextView = UITextView(frame: CGRectMake(5, 0, AppWidth - 10, 240))
        feedbackTextView?.font = UIFont.systemFontOfSize(20)
        feedbackTextView?.allowsEditingTextAttributes = true
        feedbackTextView?.autocorrectionType = UITextAutocorrectionType.No
        backView.addSubview(feedbackTextView!)
        view.addSubview(backView)
        
        contactTextView = UITextField(frame: CGRectMake(0, CGRectGetMaxY(feedbackTextView.frame) + 10, AppWidth, 50))
        contactTextView.clearButtonMode = UITextFieldViewMode.Always
        contactTextView.backgroundColor = theme.SDBackgroundColor
        contactTextView.font = UIFont.systemFontOfSize(18)
        let leftView = UIView(frame: CGRectMake(0, 0 ,10, 20));
        contactTextView.leftView = leftView
        contactTextView.leftViewMode = UITextFieldViewMode.Always
        contactTextView.placeholder = "留下邮箱或电话,以方便我们给你回复"
        contactTextView.autocorrectionType = UITextAutocorrectionType.No
        view.addSubview(contactTextView)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        feedbackTextView.becomeFirstResponder()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    deinit{
        print("反馈留言")
    }
    
    
    
    
    
    
    
    
    
    
}
