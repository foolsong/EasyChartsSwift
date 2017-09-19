//
//  ViewController.swift
//  EasyChartsSwift
//
//  Created by yjSong on 2017/9/18.
//  Copyright © 2017 Global. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var tableview : UITableView!
    
    fileprivate lazy var dataList : [NSString] = ["LineChart-1","LineChart-2","ProgressCircle",
                                                   "LineChart & ProgressCircle","PieChart","BarChart"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension ViewController{
    func setupTableView() {
        
        tableview = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.size.width,
                                              height: self.view.bounds.size.height - 64))
        tableview.frame = self.view.bounds
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        
        self.view.addSubview(tableview)
        
    }
}

extension ViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier : String = "cellidentifier"
        var cell = tableview.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = dataList[indexPath.row] as String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 4 {
            jump2PieChartViewController()
        } else if indexPath.row == 5 {
            jump2RadarChartViewController()
        }
    }
}

extension ViewController {
    func jump2RadarChartViewController() {
        self.navigationController?.pushViewController(RadarChartViewController(), animated:true)
//        self.navigationController?.pushViewController(, animated:ture as Bool)
    }
    
    func jump2PieChartViewController() {
        self.navigationController?.pushViewController(PieChartViewController(), animated:true)
    }
}
