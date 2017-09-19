//
//  PieChartViewController.swift
//  EasyChartsSwift
//
//  Created by 宋永建 on 2017/9/19.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

class PieChartViewController: UIViewController {

    var pieChartView : ECPieChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configOwnProperties()
        setupPieChartView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configOwnProperties() {
        self.view.backgroundColor = UIColor.white
    }
}

extension PieChartViewController{
    
    func setupPieChartView() {
        pieChartView = ECPieChartView.init(frame: CGRect(x: 100, y: 100,
                                                             width: 200, height: 200))
        
        self.view.addSubview(pieChartView)
        
        
        pieChartView.drawPieChart(percentList: [0.2,0.1,0.3,0.4],
                                  colorList: [UIColor.orange,UIColor.green,UIColor.red,UIColor.blue],
                                  arcTextList: ["T1","T2","T3","T4"])
    }
}
