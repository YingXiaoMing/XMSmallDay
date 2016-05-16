//
//  ThemeCell.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/16.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {
    var model: ThemeModel? {
        didSet {
            titleLabel.text = model!.title
            subTitleLabel.text = model!.keywords
            bgImageView.XM_setImageWithURL(NSURL(string: model!.img!)!, placeholderImage: UIImage(named: "quesheng")!)
        }
    }
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        self.titleLabel.shadowOffset = CGSizeMake(-1, 1)
        self.titleLabel.shadowColor = UIColor.colorWith(20, green: 20, blue: 20, alpha: 0.1)
        self.subTitleLabel.shadowOffset = CGSizeMake(-1, 1)
        self.subTitleLabel.shadowColor = UIColor.colorWith(20, green: 20, blue: 20, alpha: 0.1)
    }
    class func  themeCellWithTableView(tableView: UITableView) -> ThemeCell {
        let identifer = "themeCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifer) as? ThemeCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("ThemeCell", owner: nil, options: nil).last
            as? ThemeCell
        }
        return cell!
    }
}
