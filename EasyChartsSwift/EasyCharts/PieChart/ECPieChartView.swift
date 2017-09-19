//
//  ECPieChartView.swift
//  EasyChartsSwift
//
//  Created by 宋永建 on 2017/9/19.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

class ECPieChartView: UIView {
    
    var arcCenter : CGPoint?
    var pieChartView : ECPieChartCoreView?
    
    lazy var percentList : [CGFloat] = []
    lazy var colorList : [UIColor] = []
    lazy var arcTextList : [NSString] = []
    
    var pieChartModelList : [ECPieChartConfig] = NSMutableArray() as! [ECPieChartConfig]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        arcCenter = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.5)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ECPieChartView {
    
    func setupSubviews() {
        setupDrawCircleView()
    }
    
    func setupDrawCircleView() {
        pieChartView = ECPieChartCoreView.init(frame: self.bounds)
        pieChartView?.arcCenter = self.arcCenter
        
        self.addSubview(pieChartView!)
    }
}

extension ECPieChartView {
    
    func drawPieChart(percentList: [CGFloat], colorList: [UIColor], arcTextList: [NSString]) {
        self.percentList = percentList
        self.colorList = colorList
        self.arcTextList = arcTextList
        
        extractPieChartModelList()
        
        self.pieChartView?.resetCircleList(pieChartModelList: self.pieChartModelList)
    }
    
    
    
    func extractPieChartModelList() {
        var startAngle : CGFloat = 0
        for i in 0..<self.percentList.count {
            let pieChartConfig : ECPieChartConfig = ECPieChartConfig.init(startAngle: startAngle,
                                                                      arcPercent: self.percentList[i],
                                                                           color: self.colorList[i],
                                                                        arcText: self.arcTextList[i],
                                                                      arcCenter: self.arcCenter!)
            startAngle = pieChartConfig.endAngle
            self.pieChartModelList.insert(pieChartConfig, at: 0)
        }
        
    }
}
