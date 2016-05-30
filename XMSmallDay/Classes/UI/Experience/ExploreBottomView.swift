//
//  ExploreBottomView.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/27.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class ExploreBottomView: UIView {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var remindBtn: UIButton!
    @IBOutlet weak var arrowImageV: UIImageView!
    class func exploreBottomViewFromXib(title: String, subTitle: String, target: AnyObject,action: Selector,showBtn: Bool, showArrow: Bool)-> ExploreBottomView {
        let exploreView = NSBundle.mainBundle().loadNibNamed("ExploreBottomView", owner: nil, options: nil).last as! ExploreBottomView
        exploreView.titleLabel.text = title
        exploreView.subLabel.text = subTitle
        let tap = UITapGestureRecognizer(target: target, action: action)
        exploreView.addGestureRecognizer(tap)
        exploreView.backgroundColor = UIColor.clearColor()
        exploreView.userInteractionEnabled = true
        exploreView.remindBtn.enabled = false
        exploreView.remindBtn.hidden = !showBtn
        exploreView.arrowImageV.hidden = !showArrow
        return exploreView
    }
}
