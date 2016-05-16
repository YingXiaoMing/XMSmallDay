//
//  UIImageView+XMImage.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/16.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import Foundation

extension UIImageView {
    func XM_setImageWithURL(url: NSURL, placeholderImage: UIImage) {
        self.sd_setImageWithURL(url, placeholderImage: placeholderImage)
    }
}