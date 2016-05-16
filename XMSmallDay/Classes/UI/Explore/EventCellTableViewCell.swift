//
//  EventCellTableViewCell.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/16.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class EventCellTableViewCell: UITableViewCell {
    var eventModel: EveryDay? {
        didSet {
            cellTileLabel.text = eventModel!.events?.last?.feeltitle
            titleLabel.text = eventModel!.events?.last?.title
            subTitleLabel.text = eventModel!.events?.last?.address
            dayLabel.text = eventModel?.day
            monthLabel.text = eventModel?.month
            if let imageURL = NSURL(string: (eventModel?.events?.last?.imgs?.last!)!){
                bgImageView.XM_setImageWithURL(imageURL, placeholderImage: UIImage(named: "quesheng")!)
            }
        }
    }
    
    @IBOutlet weak var cellTileLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var monthLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
    }
    class func eventCell(tableView: UITableView) -> EventCellTableViewCell {
        let identifier = "eventCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? EventCellTableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("EventCellTableViewCell", owner: nil, options: nil).last as? EventCellTableViewCell
        }
        return cell!
    }
 
    
}
