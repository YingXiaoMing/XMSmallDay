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
    private var backgroundScrollView: UIScrollView!
    private var dayTableView: MainTableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化导航条
        setNav()
        //设置scrollView
        
    }
    private func setNav(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "附近", titleColor: UIColor.blackColor(), target: self, action: "nearClick")
        doubleTextView = DoubleTextView(leftText: "美天", rightText: "美辑")
        doubleTextView.frame = CGRectMake(0, 0, 120, 44)
        navigationItem.titleView = doubleTextView
    }
    private func setScrollView(){
        self.automaticallyAdjustsScrollViewInsets = false
        backgroundScrollView = UIScrollView(frame: CGRectMake(0,0,AppWidth,AppHeight-49))
        backgroundScrollView.backgroundColor = theme.SDBackgroundColor
        backgroundScrollView.contentSize = CGSizeMake(2 * AppWidth, 0)
        backgroundScrollView.showsHorizontalScrollIndicator = false
        backgroundScrollView.showsVerticalScrollIndicator = false
        backgroundScrollView.pagingEnabled = true
        view.addSubview(backgroundScrollView)
    }
    private func setdayTableView(){
        dayTableView = MainTableView(frame: CGRectMake(0, 0, AppWidth, AppHeight - NavigationH), style: .Grouped, delegate: self, dataSource: self)
        dayTableView.sectionFooterHeight = 0.1
        dayTableView.sectionHeaderHeight = 0.1
        dayTableView.contentInset = UIEdgeInsetsMake(-35, 0, 35, 0)
        backgroundScrollView.addSubview(dayTableView)
    }
}
//MARK: - UITableViewDelegate和UITableViewDataSource
extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    
}

