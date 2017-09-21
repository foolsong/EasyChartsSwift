//
//  ECPieChartLineView.swift
//  EasyChartsSwift
//
//  Created by 宋永建 on 2017/9/19.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

class ECPieChartLineView: UIView {
    
    var arcCenter : CGPoint = CGPoint()
    
    var layerMutableList : [CAShapeLayer] = NSMutableArray() as! [CAShapeLayer]
    var labelMutableList : [UILabel] = NSMutableArray() as! [UILabel]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ECPieChartLineView {
    func resetLine(pieConfigList: [ECPieChartConfig]) {
        clearLayersAndLabels()
        drawHalvingLine(pieConfigList: pieConfigList)
        drawDescriptionLabel(pieConfigList: pieConfigList)
    }
    
    func drawHalvingLine(pieConfigList: [ECPieChartConfig]) {
        for i in 0..<pieConfigList.count {
            let config : ECPieChartConfig = pieConfigList[i]
            if config.arcPercent >= 1 {
                break
            }
            
            drawCircle(lineWidth: 49,
                       color: UIColor.white,
                       radius: 57,
                       startAngle: config.startAngle,
                       endAngle: config.startAngle + 0.02)
        }
    }
    
    func drawCircle(lineWidth: CGFloat, color: UIColor, radius:CGFloat,
                    startAngle: CGFloat, endAngle: CGFloat) {
        let shapeLayer : CAShapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        let path : UIBezierPath = UIBezierPath(arcCenter: self.arcCenter,
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
    
    func drawDescriptionLabel(pieConfigList: [ECPieChartConfig]) {
        for i in 0..<pieConfigList.count {
            let config : ECPieChartConfig = pieConfigList[i]
            drawLine(config: config)
            setupLabel(config: config)
        }
    }
    
    func drawLine(config : ECPieChartConfig) {
        let linePath = UIBezierPath()
        linePath.move(to: config.textLeftCenterPoint)
        linePath.addLine(to: config.inflectionPoint)
        linePath.addLine(to: config.arcCenterPoint)
        
        let lineShape = CAShapeLayer()
        lineShape.frame = self.bounds
        lineShape.lineWidth = 0.5
        lineShape.path = linePath.cgPath
        lineShape.strokeColor = config.circleColor.cgColor
        lineShape.fillColor = nil
        
        self.layer.addSublayer(lineShape)
        
        self.layerMutableList.insert(lineShape, at: 0)
    }
    
    func setupLabel(config : ECPieChartConfig) {
        var frame : CGRect = CGRect()
        if (config.arcCenterQuadrant == .ArcCenterQuadrantFourth ||
            config.arcCenterQuadrant == .ArcCenterQuadrantFirst) {
            frame = CGRect(x: config.textLeftCenterPoint.x + 4,
                           y: config.textLeftCenterPoint.y - 11, width: 32, height: 22)
        } else {
            frame = CGRect(x: config.textLeftCenterPoint.x + 4 - 32,
                           y: config.textLeftCenterPoint.y - 11, width: 32,  height: 22)
        }
        let label : UILabel = UILabel()
        label.textColor = config.circleColor
        label.font = UIFont.systemFont(ofSize: 13)
        label.frame = frame
        label.text = config.arcText! as String
        self.addSubview(label)
        
        self.labelMutableList.insert(label, at: 0)
    }
    
    func clearLayersAndLabels() {
        for layer in self.layerMutableList {
            layer.removeFromSuperlayer()
        }
        self.layerMutableList.removeAll()
        
        for label in self.labelMutableList {
            label.removeFromSuperview()
        }
        self.labelMutableList.removeAll()
    }
}
