//
//  ECBrokenLinePointModel.swift
//  Examples
//
//  Created by 宋永建 on 2017/9/23.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

enum ECLineType : Int {
    case normal
    case dotted
    case noline
}

class ECBrokenLinePointModel: NSObject {
    var leftLineType : ECLineType = .noline
    var rightLineType : ECLineType = .noline
    var pointY : CGFloat?
    var titleText : NSString?
}
