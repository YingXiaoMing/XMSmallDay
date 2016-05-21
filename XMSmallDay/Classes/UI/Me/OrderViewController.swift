//
//  OrderViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/21.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    init(){
        super.init(nibName: "OrderViewController", bundle: nil)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "OrderViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的订单"
        view.backgroundColor = theme.SDBackgroundColor
    }
}
