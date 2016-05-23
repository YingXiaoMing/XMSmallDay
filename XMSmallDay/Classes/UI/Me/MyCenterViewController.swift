//
//  MyCenterViewController.swift
//  XMSmallDay
//
//  Created by Kenfor-YF on 16/5/21.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

class MyCenterViewController: UIViewController {

    @IBOutlet weak var iconView: IconView!
    @IBOutlet weak var alertPwdView: UIView!
    @IBOutlet weak var acountNameLabel: UILabel!
    init() {
        super.init(nibName: "MyCenterViewController", bundle: nil)
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: "MyCenterViewController", bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
