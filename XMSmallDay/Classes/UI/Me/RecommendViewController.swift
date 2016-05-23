//
//  RecommendViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/23.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {

    private lazy var webView: UIWebView! = {
        let webView = UIWebView(frame: MainBounds)
        let url = NSURL(string: "http://www.jianshu.com/users/1d25847912af/latest_articles")
        webView.loadRequest(NSURLRequest(URL: url!))
        webView.delegate = self
        return webView
    }()
    private let loadAnimV: LoadAnimatImageView! = LoadAnimatImageView.shareManager
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "应用推荐"
        view.backgroundColor = theme.SDBackgroundColor
        view.addSubview(webView)
    }
}
extension RecommendViewController: UIWebViewDelegate {
    func webViewDidStartLoad(webView: UIWebView) {
        loadAnimV.startLoadAnimImageViewInView(view, center: view.center)
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        loadAnimV.stopLoadAnimImageView()
    }
}