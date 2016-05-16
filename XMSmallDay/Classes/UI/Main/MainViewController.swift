//
//  MainViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var cityBtn : TextImageButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "cityChange:", name: SD_CurrentCityChange_Notification, object: nil)
        
        cityBtn = TextImageButton(frame: CGRectMake(0, 20, 80, 44))
        let user = NSUserDefaults.standardUserDefaults()
        if let currentCity = user.objectForKey(SD_Current_SelectedCity) as? String{
            cityBtn.setTitle(currentCity, forState: .Normal)
        }else{
            cityBtn .setTitle("北京", forState: .Normal)
        }

        cityBtn.titleLabel?.font = theme.SDNavItemFont
        cityBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        cityBtn.setImage(UIImage(named: "home_down"), forState: .Normal)
        cityBtn.addTarget(self, action:"pushCityView", forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityBtn)
    }
    func pushCityView() {
        let cityVc = CityViewController()
        cityVc.cityName = self.cityBtn.titleForState(.Normal)
        let nav = MainNavigationController(rootViewController: cityVc)
        presentViewController(nav, animated: true, completion: nil)
    }
    func cityChange(noti: NSNotification){
        if let currentCityName = noti.object as? String{
            self.cityBtn.setTitle(currentCityName, forState: .Normal)
        }
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
class TextImageButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = theme.SDNavItemFont
        titleLabel?.contentMode = UIViewContentMode.Center
        imageView?.contentMode = UIViewContentMode.Left
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(-5, 0, titleLabel!.width, height)
        imageView?.frame = CGRectMake(titleLabel!.width - 2 , 0, width - titleLabel!.width - 3, height)
    }
}