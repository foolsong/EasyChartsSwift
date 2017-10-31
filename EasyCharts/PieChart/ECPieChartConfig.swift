//
//  ECPieChartConfig.swift
//  EasyChartsSwift
//
//  Created by 宋永建 on 2017/9/19.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

enum ArcCenterQuadrant : Int {
    case ArcCenterQuadrantFirst
    case ArcCenterQuadrantSecond
    case ArcCenterQuadrantThird
    case ArcCenterQuadrantFourth
}

class ECPieChartConfig: NSObject {
    
    var startAngle : CGFloat = 0
    var endAngle : CGFloat = 0
    var arcPercent : CGFloat = 0
    var arcCenter : CGPoint = CGPoint()
    
    var arcCenterPoint : CGPoint = CGPoint()
    var inflectionPoint : CGPoint = CGPoint()
    var textLeftCenterPoint : CGPoint = CGPoint()
    
    var arcCenterQuadrant : ArcCenterQuadrant = .ArcCenterQuadrantFirst
    var circleColor : UIColor = UIColor.clear
    var arcText : NSString?
    
    var offset : CGFloat = 0
 
    init(startAngle: CGFloat, arcPercent: CGFloat, color: UIColor, arcText: NSString, arcCenter: CGPoint) {
        super.init()
        self.arcCenter = arcCenter
        self.circleColor = color
        self.arcPercent = arcPercent
        self.arcText = arcText
        self.startAngle = startAngle
        
        computerEndAngle()
        computerArcCenterPoint()
        computerLinePoint()
    }
}

extension ECPieChartConfig {
    fileprivate func computerEndAngle() {
        self.endAngle = self.startAngle + 2.0 * CGFloat.pi * self.arcPercent
        self.offset = 10
    }
    
    fileprivate func computerArcCenterPoint() {
        let pointX : CGFloat = self.arcCenter.x + 76.5 * cos(self.endAngle - (CGFloat.pi * self.arcPercent))
        let pointY : CGFloat = self.arcCenter.y + 76.5 * sin(self.endAngle - (CGFloat.pi * self.arcPercent))
        self.arcCenterPoint = CGPoint(x: pointX, y: pointY)
    }
    
    fileprivate func computerLinePoint() {
        if (self.arcCenterPoint.x >= self.arcCenter.x  && self.arcCenterPoint.y <= self.arcCenter.y) {
            fourthQuadrant()
            self.arcCenterQuadrant = .ArcCenterQuadrantFourth
        } else if (self.arcCenterPoint.x > self.arcCenter.x  && self.arcCenterPoint.y > self.arcCenter.y) {
            firstQuadrant()
            self.arcCenterQuadrant = .ArcCenterQuadrantFirst
        } else  if (self.arcCenterPoint.x <= self.arcCenter.x  && self.arcCenterPoint.y >= self.arcCenter.y) {
            secondQuadrant()
            self.arcCenterQuadrant = .ArcCenterQuadrantSecond
        } else {
            thirdQuadrant()
            self.arcCenterQuadrant = .ArcCenterQuadrantThird
        }
    }
    
    fileprivate func firstQuadrant() {
        self.textLeftCenterPoint = CGPoint(x: ECScreenW - 64, y:self.arcCenterPoint.y + self.offset)
        self.inflectionPoint = CGPoint(x:self.arcCenterPoint.x + self.offset, y: self.textLeftCenterPoint.y)
    }
    
    fileprivate func secondQuadrant() {
        self.textLeftCenterPoint = CGPoint(x: 60.0, y: self.arcCenterPoint.y + self.offset)
        self.inflectionPoint = CGPoint(x: self.arcCenterPoint.x - self.offset, y: self.textLeftCenterPoint.y)
    }
    
    fileprivate func thirdQuadrant() {
        self.textLeftCenterPoint = CGPoint(x: 60, y: self.arcCenterPoint.y - self.offset)
        self.inflectionPoint = CGPoint(x: self.arcCenterPoint.x - self.offset, y: self.textLeftCenterPoint.y)
    }
    
    fileprivate func fourthQuadrant() {
        self.textLeftCenterPoint = CGPoint(x: ECScreenW - 64, y: self.arcCenterPoint.y - 10)
        self.inflectionPoint = CGPoint(x: self.arcCenterPoint.x + 10, y: self.textLeftCenterPoint.y)
    }
    
    func resetLinePosition(pointY: CGFloat) {
        var currentPointY : CGFloat = 0
        if (self.arcCenterQuadrant == .ArcCenterQuadrantFirst) {
            currentPointY = pointY - 15
        } else if (self.arcCenterQuadrant == .ArcCenterQuadrantSecond) {
            currentPointY = pointY + 15
        } else if (self.arcCenterQuadrant == .ArcCenterQuadrantThird) {
            currentPointY = pointY + 15
        } else if (self.arcCenterQuadrant == .ArcCenterQuadrantFourth) {
            currentPointY = pointY - 15
        }
        
        self.textLeftCenterPoint = CGPoint(x: self.textLeftCenterPoint.x, y: currentPointY)
        self.inflectionPoint = CGPoint(x: self.inflectionPoint.x, y: self.textLeftCenterPoint.y)
    }
}
