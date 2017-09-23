//
//  BrokenLineViewController.swift
//  Examples
//
//  Created by 宋永建 on 2017/9/23.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

class BrokenLineViewController: UIViewController {
    var brokenLineView : ECBrokenLineView?
    let pointValveList : [CGFloat] = [12.0, 80.0, -1.0, 56.0, 80, -12.0, 0.0, 1.0,
                               56.0, -14.0, 12.0, 80.0, 1.0, 56.0, 34.0]
    let titleText : [NSString] = ["Jan", "Feb", "Mar",
                                       "Apr", "May", "Jun", "Jul", "Aug", "Sept",
                                       "Oct", "Nov", "Dec", "Jan", "Feb", "Mar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configOwnProperties()
        setupBrokenLineView()
        setupBrokenLineData()
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
        self.brokenLineView = ECBrokenLineView.init(frame: frame)
        self.view.addSubview(self.brokenLineView!)
    }
    
    func setupBrokenLineData() {
        self.brokenLineView?.reloadLineViewData(pointValveList: self.pointValveList,
                                                titleText: self.titleText)
    }
}
