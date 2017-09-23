//
//  ECBrokenLineView.swift
//  Examples
//
//  Created by yjSong on 2017/9/23.
//  Copyright © 2017 Global. All rights reserved.
//

import UIKit

class ECBrokenLineView: UIView {
    var normalCollectionView : ECBrokenLineNormalCollectionView?
    var maxValue : CGFloat = 100
    var minValue : CGFloat = 0
    var pointModelList : [ECBrokenLinePointModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupLineCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLineCollectionView() {
        let frame : CGRect =  CGRect(x: 0, y: 0, width: ECScreenW, height: 200)
        self.normalCollectionView =
            ECBrokenLineNormalCollectionView.init(frame: frame)
        self.addSubview(self.normalCollectionView!)
    }
    
    func reloadLineViewData(pointValveList: [CGFloat], titleText: [NSString]) {
        computerAndCombinationModelList(pointValveList: pointValveList, titleText: titleText)
        self.normalCollectionView?.reloadCollectionData(modelList: self.pointModelList)
    }
}

extension ECBrokenLineView {
    func computerAndCombinationModelList(pointValveList: [CGFloat], titleText: [NSString]) {
        var modelList : [ECBrokenLinePointModel] = []
        
        for i in 0..<pointValveList.count {
            let currentNum : CGFloat = pointValveList[i]
            let lastNum : CGFloat? = extractionNum(index: i - 1, pointValveList: pointValveList)
            let nextNum = extractionNum(index: i + 1, pointValveList: pointValveList)
            let pointModel : ECBrokenLinePointModel = ECBrokenLinePointModel()
            pointModel.leftLineType = lineType(num: currentNum, nearNum: lastNum)
            pointModel.rightLineType = lineType(num: currentNum, nearNum: nextNum)
            
            if currentNum > self.maxValue {
                pointModel.pointY = self.maxValue
            } else if currentNum < self.minValue {
                pointModel.pointY = self.minValue
            } else {
                pointModel.pointY = 100 - currentNum
            }
            
            pointModel.titleText = titleText[i]
//            pointModel.pointY =
//                15 + (1 - ((pointModel.pointY! - self.minValue)/(self.maxValue - self.brokenLineConfig.minValue))) * (self.frame.size.height - 40)
            modelList.append(pointModel)
        }
        
        self.pointModelList = modelList
    }
    
    func extractionNum(index: NSInteger, pointValveList : [CGFloat]) -> CGFloat? {
        if index < 0  || index >= pointValveList.count {
            return nil
        } else {
            return pointValveList[index]
        }
    }
    
    func lineType(num: CGFloat, nearNum: CGFloat?) -> ECLineType {
        if nearNum == nil {
            return .noline
        } else if isDottedLine(num: num, nearNum: nearNum!)  {
            return .dotted
        } else {
            return .normal
        }
    }
    
    func isDottedLine(num: CGFloat, nearNum: CGFloat) -> Bool {
        return nearNum > self.maxValue || nearNum < self.minValue
            || num > self.maxValue || num < self.minValue
    }
}
