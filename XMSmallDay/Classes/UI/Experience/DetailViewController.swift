//
//  DetailViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/26.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIActionSheetDelegate {

    private lazy var backBtn: UIButton = UIButton()
    private lazy var likeBtn: UIButton = UIButton()
    private lazy var shareBtn: UIButton = UIButton()
    private var htmlNewString: NSMutableString?
    private var loadFinishScrollHeight: CGFloat = 0
    private var isAddBottomView = false
    private var isLoadFinish = false
    private var showBlackImage: Bool = false
    private var signUpBtn: UIButton!
    private lazy var bottomViews: [ExploreBottomView] = [ExploreBottomView]()
    private lazy var phoneActionSheet: UIActionSheet? = {
        let action = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: self.model!.telephone!)
        return action
    }()
    private let scrollShowNavH: CGFloat = DetailViewController_TopImageView_height - NavigationH
    private lazy var webView: UIWebView = ExperienceWebView(frame: MainBounds, webViewDeleagte: self, webViewScrollViewDelegate: self)
    private lazy var topImageView: UIImageView = {
        let image = UIImageView(frame: CGRectMake(0, 0, AppWidth, DetailViewController_TopImageView_height))
        image.image = UIImage(named: "quesheng")
        image.contentMode = UIViewContentMode.ScaleToFill
        return image
    }()
    private lazy var customNav: UIView = {
        let customNav = UIView(frame: CGRectMake(0, 0, AppWidth, NavigationH))
        customNav.backgroundColor = UIColor.whiteColor()
        customNav.alpha = 0.0
        return customNav
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setCustomNavigationItem()
        setUpBottomView()
    }
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        if isLoadFinish && isAddBottomView {
            webView.scrollView.contentSize.height = loadFinishScrollHeight
        }
        [super.viewWillAppear(animated)]
    }
    override func viewWillDisappear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillDisappear(animated)
    }
    
    private func setUpBottomView() {
        //添加底部报名的View
        let bottomView = UIView(frame: CGRectMake(0,AppHeight - 49,AppWidth, 49))
        bottomView.backgroundColor = UIColor.whiteColor()
        view.addSubview(bottomView)
        signUpBtn = UIButton()
        signUpBtn.setBackgroundImage(UIImage(named: "registration_1"), forState: .Normal)
        signUpBtn.frame = CGRectMake((AppWidth - 158) * 0.5, (49 - 36) * 0.5, 158, 36)
        signUpBtn.setTitle("报  名", forState: .Normal)
        signUpBtn.addTarget(self, action: "signUpBtnClick", forControlEvents: .TouchUpInside)
        bottomView.addSubview(signUpBtn)
    }
    
    
    private func setUpUI() {
        view.backgroundColor = theme.SDWebViewBackgroundColor
        view.addSubview(webView)
        view.addSubview(topImageView)
        view.clipsToBounds = true
    }
    private func setCustomNavigationItem() {
        view.addSubview(customNav)
        //添加返回按钮
        setButton(backBtn, frame: CGRectMake(-7, 20, 44, 44), imageName: "back_0", highImageName: "back_2", action: "backButtonClick")
        view .addSubview(backBtn)
        //添加收藏按钮
        setButton(likeBtn, frame: CGRectMake(AppWidth - 105, 20, 44, 44), imageName: "collect_0", highImageName: "collect_0", action: "likeBtnClick")
        likeBtn.setImage(UIImage(named: "collect_2"), forState: .Selected)
        view.addSubview(likeBtn)
        //添加分享按钮
        setButton(shareBtn, frame: CGRectMake(AppWidth - 54, 20, 44, 44), imageName: "share_0", highImageName: "share_2", action: "shareBtnClick")
        view.addSubview(shareBtn)
    }
    func backButtonClick() {
        navigationController?.popViewControllerAnimated(true)
    }
    func likeBtnClick() {
        likeBtn.selected = !likeBtn.selected
    }
    private func setButton(btn: UIButton,frame: CGRect,imageName: String,highImageName: String,action: Selector) {
        btn.frame = frame
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        btn.addTarget(self, action: action, forControlEvents: .TouchUpInside)
    }
    var model: EventModel? {
        didSet {
            self.webView.hidden = true
            if let imageStr = model?.imgs?.last {
                self.topImageView.XM_setImageWithURL(NSURL(string: imageStr)!, placeholderImage: UIImage(named: "quesheng")!)
            }
            var htmlSrt = model?.mobileURL
            //添加JS代码,更改CSS布局.
            if htmlSrt != nil {
                var titleStr: String?
                if model?.title != nil {
                    titleStr = String(format: "<p style='font-size:20px;'> %@</p>", model!.title!)
                }
                if model?.tag != nil {
                    titleStr = titleStr?.stringByAppendingFormat("<p style='font-size:13px; color: gray';>%@</p>", model!.tag!)
                }
                if titleStr != nil {
                    let newStr: NSMutableString = NSMutableString(string: htmlSrt!)
                    newStr.insertString(titleStr!, atIndex: 31)
                    htmlSrt = newStr as String
                }
                htmlNewString = NSMutableString.changeHeightAndWidthWithString(NSMutableString(string: htmlSrt!))
            }
            webView.loadHTMLString(htmlNewString! as String, baseURL: nil)
            webView.scrollView.setContentOffset(CGPoint(x: 0, y: DetailViewController_TopImageView_height + 20), animated: false)
            self.webView.hidden = false
            if model!.questionURL != "" && model!.questionURL != nil {
                bottomViews.append(ExploreBottomView.exploreBottomViewFromXib("购买须知", subTitle: "价格", target: self, action: "priceBottomClick:", showBtn: false, showArrow: true))
            }
            bottomViews.append(ExploreBottomView.exploreBottomViewFromXib("每天", subTitle: "提醒", target: self, action: "remindBottomClick:", showBtn: true, showArrow: false))
            if model?.telephone != nil && model?.telephone != "" {
                bottomViews.append(ExploreBottomView.exploreBottomViewFromXib(model!.telephone!, subTitle: "电话", target: self, action:"telephoneBottomClick:", showBtn: false, showArrow: true))
            }
            if model!.position != nil && model?.position != "" && model!.address != nil && model!.address != "" {
                bottomViews.append(ExploreBottomView.exploreBottomViewFromXib(model!.address!, subTitle: "地址", target: self, action: "adressBottomClick:", showBtn: false, showArrow: true))
            }
        }
    }
    //底部按钮的四种点击方法
    func priceBottomClick(tap: UITapGestureRecognizer){
        let buyVC = BuyDetailViewController()
        buyVC.htmlStr = model!.questionURL
        navigationController?.pushViewController(buyVC, animated: true)
        
    }
    func remindBottomClick(tap: UITapGestureRecognizer){
        print("提醒")
    }
    func telephoneBottomClick(tap: UITapGestureRecognizer){
        phoneActionSheet?.showInView(view)
    }
    func adressBottomClick(tap: UITapGestureRecognizer){
        
    }
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            let url = NSURL(string: "tel://" + model!.telephone!)
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    func signUpBtnClick() {
        let signUpVc = SignUpViewController()
        navigationController?.pushViewController(signUpVc, animated: true)
    }

}



extension DetailViewController : UIWebViewDelegate
{
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.background='#F5F5F5';")
        webView.hidden = false
        isLoadFinish = true
    }
}
extension DetailViewController : UIScrollViewDelegate
{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY: CGFloat = scrollView.contentOffset.y
        
        
        customNav.alpha = 1 + (offsetY + NavigationH) / scrollShowNavH
        if offsetY >= -NavigationH && showBlackImage == false {//显示导航栏
            backBtn.setImage(UIImage(named: "back_1"), forState: .Normal)
            likeBtn.setImage(UIImage(named: "collect_1"), forState: .Normal)
            shareBtn.setImage(UIImage(named: "share_1"), forState: .Normal)
            showBlackImage = true
        }else if offsetY < -NavigationH && showBlackImage == true {//不显示导航栏
            backBtn.setImage(UIImage(named: "back_0"), forState: .Normal)
            likeBtn.setImage(UIImage(named: "collect_0"), forState: .Normal)
            shareBtn.setImage(UIImage(named: "share_0"), forState: .Normal)
            showBlackImage = false
        }
        //顶部imageView的跟随动画
        if offsetY <= -DetailViewController_TopImageView_height {//无限放大
            topImageView.frame.origin.y = 0
            topImageView.frame.size.height = -offsetY
            topImageView.frame.size.width = AppWidth - offsetY - DetailViewController_TopImageView_height
            topImageView.frame.origin.x = (0 + DetailViewController_TopImageView_height + offsetY)*0.5
        }else{
            topImageView.frame.origin.y = -offsetY - DetailViewController_TopImageView_height
        }
        if isLoadFinish && !isAddBottomView && scrollView.contentSize.height > AppHeight {
            isAddBottomView = true
            for bottomView in bottomViews {
                let bottomViewH = CGRectGetMaxY(bottomView.bottomView.frame)
                bottomView.frame = CGRectMake(0, webView.scrollView.contentSize.height, AppWidth, bottomViewH)
                webView.scrollView.contentSize.height += bottomViewH
                webView.scrollView.addSubview(bottomView)
            }
            scrollView.contentSize.height += 20
            loadFinishScrollHeight = scrollView.contentSize.height
        }
    }
}
