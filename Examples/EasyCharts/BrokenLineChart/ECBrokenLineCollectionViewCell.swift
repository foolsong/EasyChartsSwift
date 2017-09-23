//
//  ECBrokenLineCollectionViewCell.swift
//  Examples
//
//  Created by 宋永建 on 2017/9/23.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

class ECBrokenLineCollectionViewCell: UICollectionViewCell {
    
    var pointYList : [ECBrokenLinePointModel] = []
    var index : NSInteger = 0
    var pointModel : ECBrokenLinePointModel? = nil
    var cellSize : CGSize? =  CGSize(width: ECScreenW * 0.2, height: 200)
    
    var layerMutableList : [CAShapeLayer] = NSMutableArray() as! [CAShapeLayer]
    
    
    func configureCell(pointYList: [ECBrokenLinePointModel], index: NSInteger) {
        self.pointYList = pointYList
        self.index = index
        self.pointModel = self.pointYList[index]
        
        clearLayerMutableList()
        drawLeftLine()
        drawRightLine()
    }
    
    func clearLayerMutableList() {
        for lineShapeLayer in self.layerMutableList {
            lineShapeLayer.removeFromSuperlayer()
        }
         self.layerMutableList.removeAll()
    }
}
extension ECBrokenLineCollectionViewCell {
    func drawLeftLine() {
        let firstPoint : CGPoint = CGPoint(x:0, y:lastPointY())
        let nextPoint : CGPoint = CGPoint(x:(self.cellSize?.width)! * 0.5, y:currentPointY())
        if self.pointModel?.leftLineType == .normal {
            drawLine(firstPoint: firstPoint, nextPoint: nextPoint, dotted: false, lineWidth: 1.3)
        } else if self.pointModel?.leftLineType == .dotted {
            drawLine(firstPoint: firstPoint, nextPoint: nextPoint, dotted: true, lineWidth: 1.3)
        }
    }
    
    func drawRightLine() {
        let firstPoint : CGPoint = CGPoint(x:self.cellSize!.width * 0.5, y:currentPointY())
        let nextPoint : CGPoint = CGPoint(x:(self.cellSize?.width)!, y:nextPointY())
        if self.pointModel?.rightLineType == .normal {
            drawLine(firstPoint: firstPoint, nextPoint: nextPoint, dotted: false, lineWidth: 1.3)
        } else if self.pointModel?.rightLineType == .dotted {
            drawLine(firstPoint: firstPoint, nextPoint: nextPoint, dotted: true, lineWidth: 1.3)
        }
    }
    
    func drawLine(firstPoint: CGPoint, nextPoint: CGPoint, dotted: Bool, lineWidth: CGFloat) {
        let linePath = UIBezierPath()
        
        linePath.move(to: firstPoint)
        linePath.addLine(to: nextPoint)

        let lineShapeLayer = CAShapeLayer()
        lineShapeLayer.path = linePath.cgPath
        lineShapeLayer.strokeColor = UIColor.orange.cgColor
        lineShapeLayer.lineWidth = lineWidth
        self.layer.addSublayer(lineShapeLayer);
        
        self.layerMutableList.insert(lineShapeLayer, at: 0)
    }
    
    func lastPointY() -> CGFloat{
        if self.index - 1 < 0 {
            return 0
        }
        let pointModel = self.pointYList[self.index - 1]
        return (pointModel.pointY! + currentPointY()) * 0.5
    }
    
    func nextPointY() -> CGFloat {
        if self.index + 1 >= self.pointYList.count {
            return 0
        }
        let pointModel = self.pointYList[self.index + 1]
        return (pointModel.pointY! + currentPointY()) * 0.5
    }
    
    func currentPointY() -> CGFloat {
        return (self.pointModel?.pointY)!
    }
}
