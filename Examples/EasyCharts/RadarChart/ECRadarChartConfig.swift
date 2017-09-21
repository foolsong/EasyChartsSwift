//
//  RadarChartConfig.swift
//  EasyChartsSwift
//
//  Created by 宋永建 on 2017/9/18.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

class ECRadarChartConfig: NSObject {
    var backgroupLineNum : NSInteger  = 4
    var radius : CGFloat = 80
    
    var backgroupLineColor : UIColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1.0)
    var backgroupColor : UIColor = UIColor.white
    var titleColor : UIColor  = UIColor(red: 0.34, green: 0.34, blue: 0.34, alpha: 1.0)
    
    var drawPointList : [NSArray] = []
    var drawLineColorList : [UIColor] = []
    var drawLineTitleList : [NSString] = []
    
}
