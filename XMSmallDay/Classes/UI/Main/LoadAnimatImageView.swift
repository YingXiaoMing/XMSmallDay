//
//  LoadAnimatImageView.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/23.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class LoadAnimatImageView: NSObject {
    private static let shareInstance = LoadAnimatImageView()
    class var shareManager: LoadAnimatImageView {
        return shareInstance
    }
    private lazy var loadImageView: UIImageView! = {
       let loadImageView = UIImageView()
       loadImageView.animationImages = self.loadAnimImages
       loadImageView.animationDuration = 1.0
       loadImageView.animationRepeatCount = 10000
       loadImageView.frame = CGRectMake(0, 0, 44, 51)
       return loadImageView
    }()
    private lazy var loadAnimImages: [UIImage]? = {
        var images = [UIImage]()
        for i in 0...92{
            let image = UIImage(named: String(format: "wnx%02d", i))
            images.append(image!)
        }
        return images
    }()
    func startLoadAnimImageViewInView(view: UIView, center: CGPoint) {
        loadImageView.center = center
        view.addSubview(loadImageView)
        loadImageView.startAnimating()
    }
    func stopLoadAnimImageView(){
        loadImageView.removeFromSuperview()
        loadImageView.stopAnimating()
    }    
}
