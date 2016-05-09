//
//  MainTableView.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/9.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class MainTableView: UITableView {
    init(frame: CGRect, style: UITableViewStyle, delegate: UITableViewDelegate?, dataSource: UITableViewDataSource?) {
        super.init(frame: frame, style: style)
        self.delegate = delegate
        self.dataSource = dataSource
        separatorStyle = .None
        backgroundColor = theme.SDBackgroundColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
