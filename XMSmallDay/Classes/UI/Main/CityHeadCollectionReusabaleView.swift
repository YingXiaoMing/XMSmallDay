//
//  CityHeadCollectionReusabaleView.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class CityHeadCollectionReusabaleView: UICollectionReusableView {
    var headTitleLabel : UILabel = UILabel()
    var headTitle: String? {
        didSet{
            headTitleLabel.text = headTitle
            headTitleLabel.font = UIFont.systemFontOfSize(18)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    func setup(){
        headTitleLabel.textAlignment = .Center
        headTitleLabel.font = UIFont.systemFontOfSize(22)
        headTitleLabel.textColor = UIColor.blackColor()
        addSubview(headTitleLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.headTitleLabel.frame = self.bounds
    }
}

class CityFootCollectionReusabaleView: UICollectionReusableView {
    var titleLabel: UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel()
        titleLabel?.text = "更多城市,敬请期待..."
        titleLabel?.textAlignment = .Center
        titleLabel?.textColor = UIColor.darkGrayColor()
        titleLabel?.font = UIFont.systemFontOfSize(16)
        addSubview(titleLabel!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.frame = self.bounds
    }
}




















