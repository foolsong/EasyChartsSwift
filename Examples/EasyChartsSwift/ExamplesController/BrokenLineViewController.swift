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
        setupBrokenLineView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configOwnProperties() {
        self.view.backgroundColor = ECBackgroundColor
        self.title = "BrokenLine"
    }
    
    func setupBrokenLineView() {
        let frame : CGRect =  CGRect(x: 0, y: 150, width: ECScreenW, height: 200)
        let brokenLineView : ECBrokenLineView = ECBrokenLineView.init(frame: frame)
        self.view.addSubview(brokenLineView)
    }
}
