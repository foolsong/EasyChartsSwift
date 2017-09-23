//
//  PieChartViewController.swift
//  EasyChartsSwift
//
//  Created by 宋永建 on 2017/9/19.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

class PieChartViewController: UIViewController {

    var pieChartView : ECPieChartView!
    
    var percentList : [CGFloat] = [0.2,0.1,0.3,0.4]
    var colorList : [UIColor] = [UIColor(red: (64)/255.0 , green: (186)/255.0, blue: (255)/255.0, alpha: 1.0),
                                 UIColor(red: (255)/255.0, green: (133)/255.0, blue: (155)/255.0, alpha: 1.0),
                                 UIColor(red: (255)/255.0, green: (179)/255.0, blue: (0)/255.0 , alpha: 1.0),
                                 UIColor(red: (152)/255.0, green: (230)/255.0, blue: (123)/255.0, alpha: 1.0)]
    var arcTextList : [NSString] = ["T1","T2","T3","T4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configOwnProperties()
        setupPieChartView()
        setupTestButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configOwnProperties() {
        self.view.backgroundColor = ECBackgroundColor
    }
}

extension PieChartViewController{
    
    func setupPieChartView() {
        pieChartView = ECPieChartView.init(frame: CGRect(x: 0, y: 100,
                                                             width: ECScreenW, height: 260))
        
        self.view.addSubview(pieChartView)
        
        pieChartView.drawPieChart(percentList: self.percentList,
                                  colorList: self.colorList,
                                  arcTextList: self.arcTextList)
    }
    
    private func setupTestButton() {
        let width : CGFloat = 80;
        let height : CGFloat = 40;
        let x : CGFloat = (ECScreenW - width) * 0.5;
        let y : CGFloat = self.pieChartView.frame.maxY + 180;
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: x, y: y, width: width, height: height)
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(testButtonClick(button:)) , for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func testButtonClick(button:UIButton) {
        randomNumList()
        randomColorList()
        randomText()
        
        self.pieChartView.drawPieChart(percentList: self.percentList,
                                       colorList: self.colorList,
                                       arcTextList: self.arcTextList)
        
    }
    
    func randomNumList() {
        var numMutableList : [CGFloat] = NSMutableArray() as! [CGFloat]
        var sum : CGFloat = 0
        
        while true {
            let temp : CGFloat = CGFloat(arc4random_uniform(60)) + 1.0
            if sum + temp >= 100 || numMutableList.count >= 7 {
                numMutableList.insert((100.0 - sum) / 100.0, at: 0)
                break
            } else {
                numMutableList.insert((temp) / 100.0, at: 0)
                sum += temp
            }
        }
        self.percentList = numMutableList
    }
    
    func randomColorList() {
        var colorMutableList : [UIColor] = NSMutableArray() as! [UIColor]
        for _ in 0..<self.percentList.count {
            colorMutableList.insert(UIColor.ECRandomColor, at: 0)
        }
        self.colorList = colorMutableList
    }
    
    func randomText() {
        var textMutableList : [NSString] = NSMutableArray() as! [NSString]
        let textList : [NSString] = ["T1","T2","T3","T4","T5","T6","T7","T8"]
        for i in 0..<self.percentList.count {
            textMutableList.insert(textList[i], at: 0)
        }
        self.arcTextList = textMutableList
    }
}
