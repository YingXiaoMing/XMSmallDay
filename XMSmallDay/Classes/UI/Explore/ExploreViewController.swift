//
//  ExploreViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit
public let SD_RefreshImage_Height: CGFloat = 40
public let SD_RefreshImage_Width: CGFloat = 35
class ExploreViewController: MainViewController, DoubleTextViewDelegate {
    
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
        //美编的tableView
        setthemeTableView()
        //下拉加载数据
        dayTableView.mj_header.beginRefreshing()
        themesTableView.mj_header.beginRefreshing()
    }
    private func setNav(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "附近", titleColor: UIColor.blackColor(), target: self, action: "nearClick")
        doubleTextView = DoubleTextView(leftText: "美天", rightText: "美辑")
        doubleTextView.delegate = self
        doubleTextView.frame = CGRectMake(0, 0, 120, 44)
        navigationItem.titleView = doubleTextView
        
    }
    private func setScrollView(){
        self.automaticallyAdjustsScrollViewInsets = false
        backgroundScrollView = UIScrollView(frame: CGRectMake(0,64,AppWidth,AppHeight-49-64))
        backgroundScrollView.backgroundColor = theme.SDBackgroundColor
        backgroundScrollView.contentSize = CGSizeMake(2 * AppWidth, 0)
        backgroundScrollView.delegate = self
        backgroundScrollView.showsHorizontalScrollIndicator = false
        backgroundScrollView.showsVerticalScrollIndicator = false
        backgroundScrollView.pagingEnabled = true
        view.addSubview(backgroundScrollView)
    }
    private func setdayTableView(){
        dayTableView = MainTableView(frame: CGRectMake(0, 0, AppWidth, AppHeight - NavigationH), style: .Grouped, delegate: self, dataSource: self)
        dayTableView.sectionFooterHeight = 0.1
        dayTableView.sectionHeaderHeight = 0.1
//        dayTableView.contentInset = UIEdgeInsetsMake(-35, 0, 35, 0)
        backgroundScrollView.addSubview(dayTableView)
        setTableViewHeader(self, refreshingAction: "pullLoadDayData", imageFrame: CGRectMake((AppWidth - SD_RefreshImage_Width)*0.5, 47, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: dayTableView)
    }
    private func setthemeTableView(){
        themesTableView = MainTableView(frame: CGRectMake(AppWidth, 0, AppWidth, backgroundScrollView.height), style: .Plain, delegate: self, dataSource: self)
        backgroundScrollView.addSubview(themesTableView)
        setTableViewHeader(self, refreshingAction: "pullLoadThemesData", imageFrame: CGRectMake((AppWidth - SD_RefreshImage_Width) * 0.5, 47, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: themesTableView)
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
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
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
    func pullLoadThemesData(){
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            ThemeModels.loadThemesData({ (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("数据加载失败")
                    tmpSelf?.themesTableView.mj_header.endRefreshing()
                    return
                }
                tmpSelf?.themes = data!
                tmpSelf?.themesTableView.reloadData()
                tmpSelf?.themesTableView.mj_header.endRefreshing()
            })
        }
    }
    //MARK: -DoubleTextViewDelegate
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, forIndex index: Int) {
        backgroundScrollView.setContentOffset(CGPointMake(AppWidth * CGFloat(index), 0), animated: true)
    }
    //附近action点击
    func nearClick() {
        
    }
}
extension ExploreViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == backgroundScrollView {
            let index = Int(scrollView.contentOffset.x / AppWidth)
            doubleTextView.clickBtnToIndex(index)
        }
    }
}




//MARK: - UITableViewDelegate和UITableViewDataSource
extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView === themesTableView {
            return 1
        }else {
            return self.everyDays?.list?.count ?? 0
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === themesTableView {
            return themes?.list?.count ?? 0
        }else {
            let event = self.everyDays?.list![section];
            if let _ = event?.themes?.last {//数组里面有一个元素
                return 2
            }
            return 1
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView === themesTableView {
            return 240
        }else {
            if indexPath.row == 1 {
                return 220
            } else{
                return 253
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         var cell: UITableViewCell?
        if tableView === themesTableView {//美编TableView
           let theme = self.themes!.list![indexPath.row]
            cell = ThemeCell.themeCellWithTableView(tableView)
            (cell as! ThemeCell).model = theme
        }else{
           
            let event =  self.everyDays!.list![indexPath.section]
            if indexPath.row == 1{//其实就是一组的第二行啊
                cell = ThemeCell.themeCellWithTableView(tableView)
                (cell as! ThemeCell).model = event.themes?.last
            }else {
                cell = EventCellTableViewCell.eventCell(tableView)
                (cell as! EventCellTableViewCell).eventModel = event
            }
        }
       
        return cell!
    }

}

