//
//  SDRefreshHeader.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/10.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class SDRefreshHeader: MJRefreshGifHeader {
    override func prepare(){
        super.prepare()
        stateLabel!.hidden = true
        lastUpdatedTimeLabel?.hidden = true
        let idleImages = NSMutableArray()
        let idImage = UIImage(named: "wnx00")
        idleImages.addObject(idImage!)
        setImages(idleImages as [AnyObject], forState: .Idle)
        let refreshingImages = NSMutableArray()
        let refreshingImage = UIImage(named: "wnx00")!
        refreshingImages.addObject(refreshingImage)
        setImages(refreshingImages as [AnyObject], forState: .Pulling)
        let refreshingStartImages = NSMutableArray()
        for i in 0...92{
            let image = UIImage(named: String(format: "wnx%02d", i))
            refreshingStartImages.addObject(image!)
        }
        setImages(refreshingStartImages as [AnyObject], forState: .Refreshing)
    }
}
