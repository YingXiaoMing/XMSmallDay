//
//  ExperHeadPushViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/23.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class ExperHeadPushViewController: UIViewController {

    var model: ExperienceHeadModel? {
        didSet {
            webView?.loadRequest(NSURLRequest(URL: NSURL(string: model!.mobileURL!)!))
            navigationItem.title = model!.title
        }
    }
    
    
    private lazy var loadImage = LoadAnimatImageView.shareManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.SDBackgroundColor
        view.addSubview(webView!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "share_1", hightImageName: "share_2", target: self, action: "shareClick")
        // Do any additional setup after loading the view.
    }
    private lazy var webView: UIWebView? = {
       let webView = UIWebView(frame: MainBounds)
        webView.delegate = self
        webView.backgroundColor = theme.SDBackgroundColor
        webView.hidden = true
        return webView
    }()
    func shareClick() {
        
    }
}
extension ExperHeadPushViewController: UIWebViewDelegate {
    func webViewDidStartLoad(webView: UIWebView) {
        loadImage.startLoadAnimImageViewInView(view, center: view.center)
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.hidden = false
        loadImage.stopLoadAnimImageView()
        webView.scrollView.contentSize.height += NavigationH
    }
}