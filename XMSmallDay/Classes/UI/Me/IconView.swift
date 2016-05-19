//
//  IconView.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/19.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class IconView: UIView {
    var iconButton: UIButton!
    weak var delegate: IconViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    private func setUp() {
        self.backgroundColor = UIColor.clearColor()
        iconButton = UIButton(type: .Custom)
        iconButton.setImage(UIImage(named: "my"), forState: .Normal)
        iconButton.addTarget(self, action: "iconBtnClick", forControlEvents: .TouchUpInside)
        iconButton.clipsToBounds = true
        addSubview(iconButton)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = 8
        iconButton.frame = CGRectMake(margin, margin, self.width - margin * 2, self.height - margin * 2)
//        iconButton.backgroundColor = UIColor.redColor()
        
    }
    func iconBtnClick() {
        delegate?.iconView(self, didClick: self.iconButton)
    }
    override func drawRect(rect: CGRect) {
        let circleWidth: CGFloat = 2
        //圆角矩形
        let path = UIBezierPath(roundedRect: CGRectMake(circleWidth, circleWidth, rect.size.width - 2 * circleWidth, rect.size.width - 2 * circleWidth), cornerRadius: rect.size.width)
        path.lineWidth = circleWidth
        UIColor.whiteColor().set()
        path.stroke()
        
    }

}
protocol IconViewDelegate: NSObjectProtocol{
    func iconView(iconView: IconView, didClick iconButton: UIButton)
}