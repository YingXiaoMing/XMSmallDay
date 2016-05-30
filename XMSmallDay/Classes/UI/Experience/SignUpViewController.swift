//
//  SignUpViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/27.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var remarkLabel: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var nameTextF: UITextField!
    @IBOutlet weak var phoneTextF: UITextField!
    @IBOutlet weak var messageTextF: UITextField!
    @IBOutlet weak var sendCodeBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    private var timer: NSTimer?
    private var second: Int = 60
    
    init() {
        super.init(nibName: "SignUpViewController", bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "报名"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        setUpXIB()
    }
    
    func keyboardWillChangeFrame(noti: NSNotification) {
        var firstTF: UITextField?
        if nameTextF.isFirstResponder() {
            firstTF = nameTextF
        } else if phoneTextF.isFirstResponder() {
            firstTF = phoneTextF
        }else if messageTextF.isFirstResponder() {
            firstTF = messageTextF
        }
        if let userInfo = noti.userInfo {
            let newF = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue
            let boardH = AppHeight - newF.origin.y
            let animDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]! as! Double
            if firstTF != nil && boardH != 0 {
                //相对父控件来说的,所以拿到整一个View出来进行对比比较
                let maxY = CGRectGetMaxY(firstTF!.frame) + CGRectGetMinY(firstTF!.superview!.frame)
                let offsetY = boardH + maxY - AppHeight
                UIView.animateWithDuration(animDuration, animations: { () -> Void in
                    self.scrollView.contentOffset = CGPointMake(0, self.positiveNumber(offsetY))
                })
            }else {
                UIView.animateWithDuration(animDuration, animations: { () -> Void in
                    self.scrollView.contentOffset = CGPointMake(0, 0)
                })
            }
        }
      }
    private func positiveNumber(num: CGFloat) -> CGFloat {
        return num >= 0 ? num : -num
    }
    private func setUpXIB() {
        scrollView.alwaysBounceVertical = true
        let tap = UITapGestureRecognizer(target: self, action: "scrollViewClick")
        scrollView.addGestureRecognizer(tap)
        scrollView.keyboardDismissMode = .OnDrag
        sendCodeBtn.addTarget(self, action: "sendCodeBtnClick:", forControlEvents: .TouchUpInside)
    }
    func scrollViewClick() {
        view.endEditing(true)
    }
    func sendCodeBtnClick(sender: UIButton) {
        if phoneTextF.text!.validateMobile() {
            sendCodeBtn.enabled = false
            self.timer = NSTimer(timeInterval: 1.0, target: self, selector: "changeBtn", userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
            //强制触发Timer
            timer!.fire()
            messageTextF.becomeFirstResponder()
        }else {
            SVProgressHUD.setMinimumDismissTimeInterval(3.0)
            
            SVProgressHUD.showErrorWithStatus("请输入11位正确的手机号", maskType: .Black)
        }
    }
    func changeBtn() {
        sendCodeBtn.setTitle("已发送\(second)", forState: .Normal)
        second--
        if second == 0 {
            sendCodeBtn.enabled = true
            timer!.invalidate()
            self.timer = nil
            second = 60
            sendCodeBtn.setTitle("发送验证码", forState: .Normal)
        }
    }
}
