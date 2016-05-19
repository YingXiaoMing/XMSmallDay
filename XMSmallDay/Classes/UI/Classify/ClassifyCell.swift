//
//  ClassifyCell.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/17.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class ClassifyCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var classifyImage: UIImageView!
    var model: EveryClassModel? {
        didSet {
            titleLabel.text = model!.name
            classifyImage.XM_setImageWithURL(NSURL(string: model!.img!)!, placeholderImage: UIImage(named: "quesheng")!)
        }
    }
}
