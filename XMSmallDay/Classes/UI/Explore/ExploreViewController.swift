//
//  ExploreViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class ExploreViewController: MainViewController {
    
    private var doubleTextView: DoubleTextView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化导航条
        setNav()
        
    }
    private func setNav(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "附近", titleColor: UIColor.blackColor(), target: self, action: "nearClick")
        doubleTextView = DoubleTextView(leftText: "美天", rightText: "美辑")
        doubleTextView.frame = CGRectMake(0, 0, 120, 44)
        navigationItem.titleView = doubleTextView
    }
}
