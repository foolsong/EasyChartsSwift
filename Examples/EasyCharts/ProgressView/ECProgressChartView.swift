//
//  ECProgressChartView.swift
//  Examples
//
//  Created by 宋永建 on 2017/9/26.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

let ECAnimationDuration = 0.4

class ECProgressChartView: UIView {
    
    var radius: CGFloat?
    var circleCenter: CGPoint?
    
    var fromValue: CGFloat = 0
    var toValue: CGFloat = 0
    var currentProgress: CGFloat  = 0
    
    lazy var progresShapeLayer: CAShapeLayer = {
        return self.drawCircle(lineWidth: 5.0, lineColor: UIColor.white)
    }()
    
    lazy var progressPathAnima: CABasicAnimation =  {
        let pathAnima = CABasicAnimation(keyPath: "strokeEnd")
        pathAnima.duration = ECAnimationDuration
        pathAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnima.fillMode = kCAFillModeForwards
        pathAnima.isRemovedOnCompletion = false
        return pathAnima
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        computerRadiusAndCircleCenter(frame: frame)
        setupProperty()
        drawBackGroupCircle()
        setDefaultValue()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        self.backgroundColor = UIColor(red: (255 / 255.0), green: 156 / 255.0, blue: 14 / 255.0, alpha: 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        animationChangeProgress()
    }
    
}

extension ECProgressChartView {
    
    func resetProgress(progress: CGFloat) {
        self.fromValue = self.currentProgress
        self.toValue = progress
        self.currentProgress = progress
        hideProgresShapeLayerIfNeeded()
        setNeedsDisplay()
    }
    
}

extension ECProgressChartView {
    
    fileprivate func drawBackGroupCircle() {
        let backGroupColor : UIColor = UIColor(red: 255 / 255.0, green: 179 / 255.0,
                                               blue: 0 / 255.0, alpha: 1.0)
        let _ = drawCircle(lineWidth: 13.0, lineColor: backGroupColor)
        
        let backLinecolor : UIColor = UIColor(red: 255 / 255.0, green: 209 / 255.0,
                                              blue: 93 / 255.0, alpha: 1.0)
        let _ = drawCircle(lineWidth: 5.0, lineColor: backLinecolor)
    }
    
    fileprivate func animationChangeProgress() {
        self.progressPathAnima.fromValue = self.fromValue
        self.progressPathAnima.toValue = self.toValue
        self.progresShapeLayer.add(self.progressPathAnima, forKey: "strokeEndAnimation")
    }
    
    fileprivate func setDefaultValue() {
        self.fromValue = 0
        self.toValue = 0
        self.currentProgress = 0
        resetProgress(progress: self.currentProgress)
    }
    
    fileprivate func computerRadiusAndCircleCenter(frame: CGRect) {
        let sideLength: CGFloat = frame.size.width > frame.size.height ?
            frame.size.height: frame.size.width;
        self.radius = (sideLength - 13) * 0.5
        self.circleCenter = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.5)
    }
    
    fileprivate func hideProgresShapeLayerIfNeeded() {
        if self.currentProgress * 100 == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + ECAnimationDuration, execute: {
                if self.currentProgress * 100 == 0 {
                    self.progresShapeLayer.isHidden = true
                }
            })
        } else {
            self.progresShapeLayer.isHidden = false
        }
    }
    
    fileprivate  func drawCircle(lineWidth:CGFloat, lineColor:UIColor) -> CAShapeLayer  {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        let startAngle: CGFloat =  -CGFloat.pi  * 0.5
        let endAngle: CGFloat = -CGFloat.pi  * 0.5 + CGFloat.pi * 2
        
        let path: UIBezierPath = UIBezierPath(arcCenter: self.circleCenter!,
                                               radius: self.radius!,
                                               startAngle: startAngle,
                                               endAngle: endAngle,
                                               clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.strokeColor = lineColor.cgColor
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
    }
    
}
