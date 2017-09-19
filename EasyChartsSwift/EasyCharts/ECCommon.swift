//
//  ECCommon.swift
//  EasyChartsSwift
//
//  Created by 宋永建 on 2017/9/19.
//  Copyright © 2017年 Global. All rights reserved.
//

import Foundation
import UIKit


func ECLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):\(lineNum)-->\(message)");
        
    #endif
}

let  ECScreenW =  UIScreen.main.bounds.size.width

let  ECScreenH =  UIScreen.main.bounds.size.height
