//
//  BuyDetailViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/27.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class BuyDetailViewController: UIViewController {
    private lazy var webView: UIWebView = {
       let web = UIWebView(frame: CGRectMake(0, NavigationH,AppWidth, AppHeight - NavigationH))
        web.backgroundColor = theme.SDBackgroundColor
        web.scrollView.showsHorizontalScrollIndicator = false
        return web
    }()
    var htmlStr: String? {
        didSet {
            let newStr = NSMutableString.changeHeightAndWidthWithString(NSMutableString(string: htmlStr!))
            self.webView.loadHTMLString(newStr as String, baseURL: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "购买须知"
        view.addSubview(webView)
    }


}
