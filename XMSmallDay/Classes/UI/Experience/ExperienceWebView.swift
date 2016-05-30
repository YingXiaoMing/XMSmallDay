//
//  ExperienceWebView.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/26.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit
public let DetailViewController_TopImageView_height: CGFloat = 225

class ExperienceWebView: UIWebView {
    init(frame: CGRect, webViewDeleagte: UIWebViewDelegate?, webViewScrollViewDelegate: UIScrollViewDelegate?){
        super.init(frame: frame)
        scrollView.showsHorizontalScrollIndicator = false
        delegate = webViewDeleagte
        scrollView.delegate = webViewScrollViewDelegate
        let contentH: CGFloat = DetailViewController_TopImageView_height - 20
        scrollView.contentInset = UIEdgeInsetsMake(contentH, 0, 49, 0)
        backgroundColor = theme.SDWebViewBackgroundColor
        scrollView.contentSize.width = AppWidth
        paginationBreakingMode = UIWebPaginationBreakingMode.Column
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
