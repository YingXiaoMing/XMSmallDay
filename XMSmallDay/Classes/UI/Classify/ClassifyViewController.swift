//
//  ClassifyViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class ClassifyViewController: MainViewController {
    private var collectionView: UICollectionView!
    private var headTitles: NSArray = ["闲时光·发现·惊喜","涨知识·分享·丰盈"]
    private var classData: ClassifyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化导航栏
        setNav()
        setCollectionView()
        collectionView.mj_header.beginRefreshing()
    }
    private func setNav() {
        navigationItem.title = "分类"
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "search_1", hightImageName: "search_2", target: self, action: "searchClick")
        self.automaticallyAdjustsScrollViewInsets = false
    }
    func searchClick() {
        
    }
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 10
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        let itemH: CGFloat = 80
        let itemW = (AppWidth - 4 * margin) / 3
        layout.itemSize = CGSizeMake(itemW, itemH)
        layout.headerReferenceSize = CGSizeMake(AppWidth, 50)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = theme.SDBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        
        collectionView.registerClass(CityHeadCollectionReusabaleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headCell")
        collectionView.registerNib(UINib(nibName: "ClassifyCell", bundle: nil), forCellWithReuseIdentifier: "classifyCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        view.addSubview(collectionView)
        
        let diyHeader = SDRefreshHeader(refreshingTarget: self, refreshingAction: "loadDatas")
        diyHeader.lastUpdatedTimeLabel!.hidden = true
        diyHeader.stateLabel!.hidden = true
        diyHeader.gifView!.frame = CGRectMake((AppWidth - SD_RefreshImage_Width) * 0.5, 64, SD_RefreshImage_Width, SD_RefreshImage_Height)
        collectionView.mj_header = diyHeader
        
        
    }
    func loadDatas() {
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            ClassifyModel.loadClassifyModel({ (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("发生未知错误")
                    tmpSelf?.collectionView.mj_header .endRefreshing()
                    return
                }
                tmpSelf?.classData = data!
                tmpSelf?.collectionView.mj_header.endRefreshing()
                tmpSelf?.collectionView.reloadData()
                
            })
        }
    }
}


extension ClassifyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.classData?.list?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.classData?.list?[section].tags?.count ?? 0
        
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("classifyCell", forIndexPath: indexPath) as! ClassifyCell
        cell.model = classData!.list![indexPath.section].tags![indexPath.row]
        return cell
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headCell", forIndexPath: indexPath) as! CityHeadCollectionReusabaleView
        headView.headTitle = self.classData?.list![indexPath.section].title
        return headView
    }
}
















