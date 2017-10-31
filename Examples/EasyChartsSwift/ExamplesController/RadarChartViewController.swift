//
//  RadarChartViewController.swift
//  EasyChartsSwift
//
//  Created by yjSong on 2017/9/18.
//  Copyright © 2017 Global. All rights reserved.
//

import UIKit

class RadarChartViewController: UIViewController {

    var radarChartView : ECRadarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configOwnProperties()
        setupRadarChartView()
        setupRadarChartView2()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configOwnProperties() {
        self.view.backgroundColor = UIColor.white
    }
}

extension RadarChartViewController {
    func setupRadarChartView() {
        radarChartView = ECRadarChartView.init(frame:CGRect(x: 40, y: 120, width: 280, height: 200))
        self.view.addSubview(radarChartView)
        
        let radarChartConfig = ECRadarChartConfig()
        radarChartConfig.radius = 110
        radarChartConfig.drawLineTitleList = ["Execution","Thinking","Endurance","Speed","Power","Technology"]
        radarChartConfig.drawPointList = [[(0.3),(0.6),(0.8),(0.2),(0.5),(0.3)],[(0.6),(0.1),(0.4),(0.8),(0.2),(0.9)]]
        radarChartConfig.drawLineColorList = [UIColor.orange, UIColor.red]
        radarChartView.setupRadarChartConfig(radarChartConfig: radarChartConfig)
    }
    
    func setupRadarChartView2() {
        radarChartView = ECRadarChartView.init(frame:CGRect(x: 40, y: 400, width: 280, height: 200))
        self.view.addSubview(radarChartView)
        
        let radarChartConfig = ECRadarChartConfig()
        radarChartConfig.radius = 110
        radarChartConfig.drawLineTitleList = ["Execution","Thinking","Endurance","Speed","Power"]
        radarChartConfig.drawPointList = [[(0.3),(0.6),(0.8),(0.2),(0.5)]]
        radarChartConfig.drawLineColorList = [UIColor.orange]
        radarChartView.setupRadarChartConfig(radarChartConfig: radarChartConfig)
    }
}
