//
//  CityCollectionViewCell.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/7.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    private var textLabel : UILabel = UILabel()
    var cityName : String? {
        didSet {
            textLabel.text = cityName
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel.textColor = UIColor.blackColor()
        textLabel.textAlignment = .Center
        textLabel.backgroundColor = UIColor.whiteColor()
        textLabel.highlightedTextColor = UIColor.redColor()
        contentView.addSubview(textLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = self.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
