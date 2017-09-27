//
//  ProgressChartViewController.swift
//  Examples
//
//  Created by 宋永建 on 2017/9/26.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

class ProgressChartViewController: UIViewController {

    var radarChartView : ECRadarChartView!
    var progressView : ECProgressChartView?
    var progressLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configOwnProperties()
        setupSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configOwnProperties() {
        self.view.backgroundColor = UIColor.white
    }
}

extension ProgressChartViewController {
    func setupSubviews() {
        setupProgressChartView()
        setupTestButton()
        setupProgressLable()
    }
    
    func setupProgressChartView() {
        self.progressView = ECProgressChartView.init(frame: CGRect(x: (ECScreenW - 200) * 0.5,
                                                                   y: 100,
                                                                   width: 200,
                                                                   height: 200))
        self.view.addSubview(progressView!)
        
//        self.progressView?.resetProgress(progress: 0.4)
    }
    
    func setupTestButton() {
        let width : CGFloat = 80;
        let height : CGFloat = 40;
        let x : CGFloat = (ECScreenW - width) * 0.5;
        let y : CGFloat = (self.progressView?.frame.maxY)! + 180;
        
        let button = UIButton(type: .custom)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.frame = CGRect(x: x, y: y, width: width, height: height)
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(testButtonClick(button:)) , for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func setupProgressLable() {
        let width : CGFloat = 80;
        let height : CGFloat = 40;
        let x : CGFloat = (ECScreenW - width) * 0.5;
        let y : CGFloat = (self.progressView?.frame.maxY)! + 80;
        
        self.progressLabel = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        self.progressLabel?.tintColor = UIColor.black
        self.progressLabel?.text = "0%"
        self.progressLabel?.textAlignment = .center
        self.view.addSubview(self.progressLabel!)
    }
    
    @objc func testButtonClick(button:UIButton) {
        let progress = CGFloat(arc4random_uniform(100)) / 100.0
        
        self.progressView?.resetProgress(progress: progress)
        self.progressLabel?.text = String(stringInterpolationSegment: progress * 100) + "%"
    }
}
