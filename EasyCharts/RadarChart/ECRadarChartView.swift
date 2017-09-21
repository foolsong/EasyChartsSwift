//
//  RadarChartView.swift
//  EasyChartsSwift
//
//  Created by yjSong on 2017/9/18.
//  Copyright © 2017 Global. All rights reserved.
//

import UIKit

class ECRadarChartView: UIView {
    
    var radarChartConfig : ECRadarChartConfig = ECRadarChartConfig()
    var angleNum : NSInteger {
        get{
            return radarChartConfig.drawLineTitleList.count
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubView() {
        for i in 0..<radarChartConfig.backgroupLineNum {
            backgroupLineWithRadius(radius: radarChartConfig.radius -
                (CGFloat(i) * (radarChartConfig.radius / CGFloat(radarChartConfig.backgroupLineNum))))
        }
    }
    
    deinit {
        ECLog("deinit")
    }
    
}

extension ECRadarChartView {
    func backgroupLineWithRadius(radius: CGFloat) {
        let linePath = UIBezierPath()
        for i in 0..<angleNum {
            let point : CGPoint = calcCircleCoordinate(center: CGPoint(x: self.frame.size.width * 0.5,
                                                                       y: self.frame.size.height * 0.5),
                                                       angle: CGFloat((360.0 / Float(angleNum)) * (Float(i) + 1.0)),
                                                       radius: radius)
            if i == 0 {
                linePath.move(to: point)
            } else {
                linePath.addLine(to: point)
            }
        }
        linePath.close()
        let lineShape = CAShapeLayer()
        lineShape.frame = self.bounds
        lineShape.lineWidth = 0.5
        lineShape.path = linePath.cgPath
        
        lineShape.strokeColor = radarChartConfig.backgroupLineColor.cgColor
        lineShape.fillColor = radarChartConfig.backgroupColor.cgColor
        
        self.layer.addSublayer(lineShape)
    }
    
    func backgroupStraightLine() {
        for i in 0..<self.angleNum {
            let linePath = UIBezierPath()
            let point : CGPoint = calcCircleCoordinate(center: CGPoint(x: self.frame.size.width * 0.5,
                                                                       y: self.frame.size.height * 0.5),
                                                       angle: CGFloat((360.0 / Float(angleNum)) * (Float(i) + 1.0)),
                                                       radius: radarChartConfig.radius)
            
            linePath.move(to: CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5))
            linePath.addLine(to: point)
            linePath.close();
            let lineShape = CAShapeLayer()
            lineShape.path = linePath.cgPath
            lineShape.strokeColor = radarChartConfig.backgroupLineColor.cgColor
            lineShape.lineWidth = 0.8
            self.layer.addSublayer(lineShape);
        }
    }
    
    func setupLabels() {
        for i in 0..<self.angleNum {
            let title : NSString = radarChartConfig.drawLineTitleList[i]
            let labelWidth : CGFloat = textSize(text: title as String,
                                           font: UIFont.systemFont(ofSize: 14),
                                           maxSize: CGSize(width: 100.0, height: 20.0)).width
            let temp : CGFloat = ((360.0 / CGFloat(self.angleNum)) * CGFloat(i + 1)  + 90) * CGFloat.pi / 180.0
            let radius : CGFloat = self.radarChartConfig.radius +
                CGFloat(fabs(cosf(Float(temp)) * Float(labelWidth) * 0.5 )) + 10.0;
            let point : CGPoint = calcCircleCoordinate(center: CGPoint(x: self.frame.size.width * 0.5,
                                                                       y: self.frame.size.height * 0.5),
                                                       angle: CGFloat((360.0 / Float(angleNum)) * (Float(i) + 1.0)),
                                                       radius: radius)
            let label : UILabel =  UILabel(frame:CGRect(x:0, y:0, width:labelWidth, height:20))
            label.font = UIFont.systemFont(ofSize: 14)
            label.center = point
            label.text = title as String
            label.textColor = self.radarChartConfig.titleColor
            self.addSubview(label)
        }
    }
    
    func radarLineWithRoleIndex(index: NSInteger) {
        let valueList : [NSNumber] = self.radarChartConfig.drawPointList[index] as! [NSNumber]
        let lineColor : UIColor = self.radarChartConfig.drawLineColorList[index]
        let linePath = UIBezierPath()
        for i in 0..<angleNum {
            let radius : CGFloat = CGFloat(truncating: valueList[i]) * self.radarChartConfig.radius
            let point : CGPoint = calcCircleCoordinate(center: CGPoint(x: self.frame.size.width * 0.5,
                                                                       y: self.frame.size.height * 0.5),
                                                       angle: CGFloat((360.0 / Float(angleNum)) * (Float(i) + 1.0)),
                                                       radius: radius)
            if i == 0 {
                linePath.move(to: point)
            } else {
                linePath.addLine(to: point)
            }
            let lineShape : CAShapeLayer = drawCircle(radius: 3, lineWidth: 1.5, lineColor: lineColor)
            lineShape.position = point
            self.layer.addSublayer(lineShape)
        }
        linePath.close()
        let lineShape = CAShapeLayer()
        lineShape.frame = self.bounds
        lineShape.lineWidth = 0.5
        lineShape.path = linePath.cgPath
        lineShape.strokeColor = lineColor.withAlphaComponent(0.8).cgColor
        lineShape.fillColor = lineColor.withAlphaComponent(0.5).cgColor
        
        self.layer.addSublayer(lineShape)
    }
    
    
    func drawCircle (radius: CGFloat, lineWidth: CGFloat, lineColor: UIColor) -> CAShapeLayer {
        let lineShape = CAShapeLayer()
        lineShape.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let startAngle : CGFloat = -(CGFloat.pi / 2)
        let endAngle : CGFloat = -(CGFloat.pi / 2) + CGFloat.pi * 2
        
        let linePath : UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0),
                                                   radius: radius, startAngle: startAngle,
                                                   endAngle: endAngle, clockwise: true)
        lineShape.path = linePath.cgPath
        lineShape.fillColor = lineColor.cgColor;
        lineShape.lineWidth = lineWidth;
        lineShape.lineCap = kCALineCapButt;
        lineShape.strokeColor = lineColor.cgColor;
        
        return lineShape
     }
}

extension ECRadarChartView {
    func calcCircleCoordinate(center: CGPoint, angle: CGFloat, radius: CGFloat) -> CGPoint {
        ECLog("\(center)")
        let angleTemp : CGFloat = angle + 90.0
        let x : CGFloat = radius * CGFloat(cosf(Float(angleTemp) * Float.pi / 180.0))
        let y : CGFloat = radius * CGFloat(sinf(Float(angleTemp) * Float.pi / 180.0))
        return CGPoint(x: center.x + x ,y: center.y - y)
    }
    
    func setupRadarChartConfig(radarChartConfig: ECRadarChartConfig) {
        self.radarChartConfig = radarChartConfig
        setupSubView()
        backgroupStraightLine()
        for i in 0...self.radarChartConfig.drawLineColorList.count - 1 {
            radarLineWithRoleIndex(index: i)
        }
        setupLabels()
    }
    
    func textSize(text: String , font: UIFont , maxSize: CGSize) -> CGSize{
        return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin],
                                 attributes: [NSAttributedStringKey.font : font],
                                 context: nil).size
    }

}
