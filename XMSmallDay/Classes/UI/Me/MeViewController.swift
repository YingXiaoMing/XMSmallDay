//
//  MeViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit
enum XMMineCellType: Int {
    //个人中心
    case MyCenter = 0
    //我的订单
    case MyOrder = 1
    //我的收藏
    case MyCollect = 2
    //反馈留言
    case Feedback = 3
    //应用推荐
    case RecommendApp = 4
}



class MeViewController: MainViewController {
    private var loginLabel: UILabel!
    private var tableView: UITableView!
    private lazy var pickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
//        pickVC.delegate = self
        pickVC.allowsEditing = true
        return pickVC
    }()
    private var iconView: IconView?
    
    private lazy var mineIcons: NSMutableArray = NSMutableArray(array: ["usercenter", "orders", "setting_like", "feedback", "recomment"])
    private lazy var mineTitles: NSMutableArray = NSMutableArray(array: ["个人中心","我的订单","我的收藏","留言反馈","应用推荐"])
//    private lazy var iconActionSheet: UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从手机相册选择")
    override func viewDidLoad() {
        //初始化导航条上的内容
        setNav()
        //设置tableView
        setTableView()
    }
    private func setNav() {
        navigationItem.title = "我的"
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "settinghhhh", hightImageName: "settingh", target: self, action: "settingClick")
    }
    private func setTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView(frame: CGRectMake(0, 64, AppWidth, AppHeight - NavigationH - 49), style: UITableViewStyle.Grouped)
        tableView.backgroundColor = UIColor.colorWith(245, green: 245, blue: 245, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 45
        tableView.sectionFooterHeight = 0.1
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        view.addSubview(tableView)
        
        //设置tableView的headerView
        let iconImageViewHeight: CGFloat = 180
        let iconImageView = UIImageView(frame: CGRectMake(0, 0, AppWidth, iconImageViewHeight))
        iconImageView.image = UIImage(named: "quesheng")
        iconImageView.userInteractionEnabled = true
        
        //未登录的文字
        let loginLabelHeight: CGFloat = 40
        loginLabel = UILabel(frame: CGRectMake(0,iconImageViewHeight - loginLabelHeight, AppWidth,loginLabelHeight))
        loginLabel.textAlignment = .Center
        loginLabel.text = "登录,开始我的小茗日记"
        loginLabel.font = UIFont.systemFontOfSize(16)
        loginLabel.textColor = UIColor.colorWith(80, green: 80, blue: 80, alpha: 1)
        iconImageView.addSubview(loginLabel)
        
        //iconImageView
        iconView = IconView(frame: CGRectMake(0, 0, 100, 100))
        iconView!.delegate = self
        iconView?.center = CGPointMake(iconImageView.width * 0.5, (iconImageViewHeight - loginLabelHeight) * 0.5 + 8)
        iconImageView.addSubview(iconView!)
        tableView.tableHeaderView = iconImageView

        
    }
    func settingClick() {
        
    }
}

extension MeViewController: IconViewDelegate {
    func iconView(iconView: IconView, didClick iconButton: UIButton) {
        let loginVc = LoginViewController()
        navigationController?.pushViewController(loginVc, animated: true)
    }
}



extension MeViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return mineIcons.count
        }else {
            return 1
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            cell!.accessoryType =  UITableViewCellAccessoryType.DisclosureIndicator
            cell!.selectionStyle = .None
        }
        if indexPath.section == 0{
            cell!.imageView!.image = UIImage(named: mineIcons[indexPath.row] as! String)
            cell!.textLabel?.text = mineTitles[indexPath.row] as? String
        }else {
            cell!.imageView!.image = UIImage(named: "yaoyiyao")
            cell!.textLabel!.text = "摇一摇 每天都不会有惊喜"
        }
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == XMMineCellType.Feedback.hashValue{
            let feedVC = feedbackViewController()
            navigationController?.pushViewController(feedVC, animated: true)
        }else if indexPath.row == XMMineCellType.MyOrder.hashValue{
            let orderVc = OrderViewController()
            navigationController?.pushViewController(orderVc, animated: true)
        } 
    }
}































