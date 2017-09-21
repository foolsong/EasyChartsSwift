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
    var pieChartLineView : ECPieChartLineView?
    
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
        setupPieChartLineView()
    }
    
    func setupDrawCircleView() {
        pieChartView = ECPieChartCoreView.init(frame: self.bounds)
        pieChartView?.arcCenter = self.arcCenter
        self.addSubview(pieChartView!)
    }
    
    func setupPieChartLineView() {
        pieChartLineView = ECPieChartLineView.init(frame: self.bounds)
        pieChartLineView?.arcCenter = self.arcCenter!
        self.addSubview(pieChartLineView!)
    }
}

extension ECPieChartView {
    
    func drawPieChart(percentList: [CGFloat], colorList: [UIColor], arcTextList: [NSString]) {
        self.percentList = percentList
        self.colorList = colorList
        self.arcTextList = arcTextList
        
        extractPieChartModelList()
        
        checkExceptionData()
        
        self.pieChartView?.resetCircleList(pieChartModelList: self.pieChartModelList)
        
        self.pieChartLineView?.resetLine(pieConfigList: self.pieChartModelList)
    }
    
    func extractPieChartModelList() {
        self.pieChartModelList.removeAll()
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
    
    func checkExceptionData() {
        var lastConfig : ECPieChartConfig = self.pieChartModelList.last!
        
        for config in self.pieChartModelList {
            if config.arcCenterQuadrant == lastConfig.arcCenterQuadrant &&
                fabs(config.textLeftCenterPoint.y - lastConfig.textLeftCenterPoint.y) < 15 {
                config.resetLinePosition(pointY: lastConfig.textLeftCenterPoint.y)
            }
            lastConfig = config
        }
    }
}
