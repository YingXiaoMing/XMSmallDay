//
//  ExploreViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit
public let SD_RefreshImage_Height: CGFloat = 40
public let SD_RefreshImage_Width: CGFloat =35
class ExploreViewController: MainViewController {
    
    private var doubleTextView: DoubleTextView!
    private var backgroundScrollView: UIScrollView!
    private var dayTableView: MainTableView!
    private var themesTableView: MainTableView!
    private var everyDays: EveryDays?
    private var themes: ThemeModels?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化导航条
        setNav()
        //设置scrollView
        setScrollView()
        //美天的tableView
        setdayTableView()
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
        setTableViewHeader(self, refreshingAction: "pullLoadDayData", imageFrame: CGRectMake((AppWidth - SD_RefreshImage_Width)*0.5, 47, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: dayTableView)
    }
    private func setthemeTableView(){
        themesTableView = MainTableView(frame: CGRectMake(AppWidth, 0, AppWidth, backgroundScrollView.height), style: .Plain, delegate: self, dataSource: self)
        backgroundScrollView.addSubview(themesTableView)
    }
    private func setTableViewHeader(refreshingTarget: AnyObject, refreshingAction: Selector, imageFrame: CGRect, tableView: UITableView) {
        let header = SDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header.gifView?.frame = imageFrame
        tableView.mj_header = header
    }
    //MARK: -下拉加载刷新数据
    func pullLoadDayData() {
        weak var tmpSelf = self
        //模拟加载数据
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.6 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            EveryDays.loadEventsData({ (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("数据加载失败哦")
                    tmpSelf?.dayTableView.mj_header.endRefreshing()
                    return
                }
                tmpSelf?.everyDays = data!
                tmpSelf?.dayTableView .reloadData()
                tmpSelf?.dayTableView.mj_header.endRefreshing()
            })
        }
    }
}
//MARK: - UITableViewDelegate和UITableViewDataSource
extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
    }
}

