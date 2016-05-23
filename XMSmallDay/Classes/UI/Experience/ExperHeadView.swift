//
//  ExperHeadView.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/20.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit
class ExperHeadView: UIView, UIScrollViewDelegate{
    weak var delegate: ExperHeadViewDelegate?
    var experModel: ExperienceModel? {
        didSet {
            if experModel?.list?.count > 0 {
              page.numberOfPages = experModel!.head!.count
              scrollImageView.contentSize = CGSizeMake(self.width * CGFloat(experModel!.head!.count), 0)
                for i in 0..<experModel!.head!.count {
                    let imageV = UIImageView(frame: CGRectMake(CGFloat(i) * AppWidth, 0, AppWidth, self.height * 0.8))
                    imageV.XM_setImageWithURL(NSURL(string: experModel!.head![i].adurl!)!, placeholderImage: UIImage(named: "quesheng")!)
                    imageV.tag = i + 1000;
                    let tap = UITapGestureRecognizer(target: self, action: "imageClick:")
                    imageV.userInteractionEnabled = true
                    imageV.addGestureRecognizer(tap)
                    scrollImageView.addSubview(imageV)
                }
            }
        }
    }
    func imageClick(tap: UITapGestureRecognizer){
        delegate?.experHeadView(self, didClickIndexOfTag: tap.view!.tag - 1000)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = theme.SDBackgroundColor
        addSubview(scrollImageView)
        addSubview(page)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollImageView.frame = CGRectMake(0, 0, self.width, self.height * 0.8)
        page.frame = CGRectMake(0, self.height * 0.8, self.width, self.height * 0.2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var scrollImageView: UIScrollView = {
       let scrollImageView = UIScrollView()
        scrollImageView.delegate = self
        scrollImageView.showsHorizontalScrollIndicator = false
        scrollImageView.showsVerticalScrollIndicator = false
        scrollImageView.pagingEnabled = true
        return scrollImageView
    }()
    private var page: UIPageControl = {
        let page = UIPageControl()
        page.pageIndicatorTintColor = UIColor.grayColor()
        page.currentPageIndicatorTintColor = UIColor.blackColor()
        page.hidesForSinglePage = true
        return page
    }()
}

//MARK:- UIScrollViewDelegate
extension ExperHeadView {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let flag = Int(scrollView.contentOffset.x / scrollView.width)
        page.currentPage = flag
    }
}
//MARK:- 协议
protocol ExperHeadViewDelegate: NSObjectProtocol {
    func experHeadView(headView: ExperHeadView, didClickIndexOfTag  index:Int)
}






















