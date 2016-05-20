//
//  ExperienceCell.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/20.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class ExperienceCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    var eventModel: EventModel? {
        didSet {
            titleLabel.text = eventModel!.title
            if eventModel!.imgs?.count > 0 {
                let urlStr = eventModel!.imgs![0]
                imageV.XM_setImageWithURL(NSURL(string: urlStr)!, placeholderImage: UIImage(named: "quesheng")!)
            }
        }
    }
}
