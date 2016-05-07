//
//  CityViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit
public let SD_Current_SelectedCity = "SD_Current_SelectedCity"
public let SD_CurrentCityChange_Notification = "SD_CurrentCityChange_Notification"
class CityViewController: UIViewController {
    var cityName : String?
    var layout = UICollectionViewFlowLayout()
    var collectionView : UICollectionView!
    lazy var domesticCity: NSMutableArray = {
       let array = NSMutableArray(array: ["北京","上海","成都","广州","杭州","西安","重庆","厦门","台北"])
        return array
    }()
    lazy var overseaCity : NSMutableArray = {
       let array = NSMutableArray(array: ["北海道","罗马","德国","威尼斯","英格兰","甲米"])
        return array
    }()
    
    override func viewDidLoad() {
        setNav()
        setCollectionView()
        let lastSelectedCityIndexPath = selectedCurrentCity()
        collectionView.selectItemAtIndexPath(lastSelectedCityIndexPath, animated: true, scrollPosition: .None)
        
    }
    private func selectedCurrentCity() -> NSIndexPath{
        if let currentCityName = self.cityName{
            for var i = 0; i < domesticCity.count; i++ {
                if currentCityName == domesticCity[i] as! String{
                    return NSIndexPath(forItem: i, inSection: 0)
                }
            }
            for var i = 0; i < overseaCity.count; i++ {
                if currentCityName == overseaCity[i] as! String {
                    return NSIndexPath(forItem: i, inSection: 1)
                }
            }
        }
        return NSIndexPath(forItem: 0, inSection: 0)
    }
    private func setNav(){
        view.backgroundColor = theme.SDBackgroundColor
        navigationItem.title = "选择城市"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", titleColor: UIColor.blackColor(), target: self, action: "cancle")
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Done, target: self, action: "cancle")
    }
    private func setCollectionView(){
        //设置布局
        let itemW = AppWidth / 3.0 - 1.0
        let itemH : CGFloat = 50
        layout.itemSize = CGSizeMake(itemW, itemH)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.headerReferenceSize = CGSizeMake(view.width, 60)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(CityCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.registerClass(CityHeadCollectionReusabaleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headCell")
        collectionView.registerClass(CityFootCollectionReusabaleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footCell")
        collectionView.backgroundColor = UIColor.colorWith(247, green: 247, blue: 247, alpha: 1)
        
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        
    }
    func cancle(){
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return domesticCity.count
        }else{
            return overseaCity.count
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CityCollectionViewCell
        if indexPath.section == 0{
            cell.cityName = domesticCity.objectAtIndex(indexPath.row) as? String
        }else{
            cell.cityName = overseaCity.objectAtIndex(indexPath.row) as? String
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter && indexPath.section == 1 {
            let footView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footCell", forIndexPath: indexPath) as! CityFootCollectionReusabaleView
            footView.frame.size.height = 80
            return footView
        }
        let headView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headCell", forIndexPath: indexPath) as! CityHeadCollectionReusabaleView
        if indexPath.section == 0{
            headView.headTitle = "国内城市"
        }else{
            headView.headTitle = "国外城市"
        }
        return headView
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CityCollectionViewCell
        let currentCity = cell.cityName
        let user = NSUserDefaults.standardUserDefaults()
        user.setObject(currentCity, forKey: SD_Current_SelectedCity)
        user.synchronize()
        NSNotificationCenter.defaultCenter().postNotificationName(SD_CurrentCityChange_Notification, object: currentCity)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //没有实现向对应的协议和自定义的layout,所以你要设置flow的foot高度需要手敲
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeZero
        }else{
            return CGSizeMake(view.width, 120)
        }
    }
}