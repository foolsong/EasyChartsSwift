//
//  BrokenLineViewController.swift
//  Examples
//
//  Created by 宋永建 on 2017/9/23.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

class BrokenLineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configOwnProperties()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configOwnProperties() {
        self.view.backgroundColor = ECBackgroundColor
        self.title = "BrokenLine"
    }
}
