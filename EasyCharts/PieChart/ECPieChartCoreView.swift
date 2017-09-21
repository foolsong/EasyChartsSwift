//
//  ECPieChartCoreView.swift
//  EasyChartsSwift
//
//  Created by 宋永建 on 2017/9/19.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

class ECPieChartCoreView: UIView {
    
    var arcCenter : CGPoint?
    var layerMutableList : [CAShapeLayer] = NSMutableArray() as! [CAShapeLayer]
    var pieChartModelList : [ECPieChartConfig] = NSArray() as! [ECPieChartConfig]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ECPieChartCoreView {
    
    func resetCircleList(pieChartModelList: [ECPieChartConfig]) {
        clearLayers()
        self.pieChartModelList = pieChartModelList
        for config in self.pieChartModelList {
            drawBackGroupCircle(config: config)
        }
    }
    
    func drawBackGroupCircle(config: ECPieChartConfig) {
        
        drawCircle(lineWidth: 5.0,
                   color: config.circleColor.withAlphaComponent(0.4),
                   radius: 35.0,
                   startAngle: config.startAngle,
                   endAngle: config.endAngle)
        
        drawCircle(lineWidth: 39.0,
                   color: config.circleColor.withAlphaComponent(1.0),
                   radius: 57.0,
                   startAngle:config.startAngle,
                   endAngle: config.endAngle)
        
        drawCircle(lineWidth: 5.0,
                   color: config.circleColor.withAlphaComponent(0.2),
                   radius: 79,
                   startAngle: config.startAngle,
                   endAngle: config.endAngle)
    }
    
    func drawCircle(lineWidth: CGFloat, color: UIColor, radius:CGFloat,
                    startAngle: CGFloat, endAngle: CGFloat) {
        let shapeLayer : CAShapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        let path : UIBezierPath = UIBezierPath(arcCenter: self.arcCenter!,
                                                  radius: radius,
                                              startAngle: startAngle,
                                                endAngle: endAngle,
                                               clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapButt
        shapeLayer.strokeColor = color.cgColor
        self.layer.addSublayer(shapeLayer)
        
        self.layerMutableList.insert(shapeLayer, at: 0)
    }
    
    func clearLayers() {
        for layer in self.layerMutableList {
            layer.removeFromSuperlayer()
        }
        self.layerMutableList.removeAll()
    }
}
