# <center>EasyCharts     <img src="https://github.com/foolsong/EasyCharts/blob/master/gif/ec_blog_9_14.png"  width=60 alt="EC_logo" /></center>
<!-- ![](https://github.com/foolsong/EasyCharts/blob/master/gif/ec_blog_9_14.png)  -->
A simple chart lib used for iOS  (swift).  :-)       [Objective-c](https://github.com/foolsong/EasyCharts)

[中文说明](http://blog.csdn.net/foolsong/article/details/77811429)

## Requirements
* ARC
* iOS>=8.0
* iPhone  || iPad
* Xcode 8.0 or later

## Features
 - [ ] BrokenLineChart 
 - [x] PieChart
 - [ ] ProgressChart 
 - [ ] BarGraph
 - [x] RadarMap

**Continuously updating ...…**

## Installation

At present 
* by cloning the project into your repository

<!-- EasyCharts supports multiple methods for installing the library in a project.
* using CocoaPods
* using Carthage -->


## Usage

<!--### Import header file-->


The following describes the basic use of several graphs.


### PieChart

Initialization--Just transfer `frame`.

```Swift
 var pieChartView : ECPieChartView!
 pieChartView = ECPieChartView.init(frame: CGRect(x: 0, y: 100, width: ECScreenW, height: 260))
  self.view.addSubview(pieChartView)
```

Data filling:Three parameters:percentList、colorList、arcTextList]

```Swift
pieChartView.drawPieChart(percentList: self.percentList,
                                  colorList: self.colorList,
                                  arcTextList: self.arcTextList)
```



**The effect of PieChart:**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_%20PieChart_gif.gif"  width=300 alt="EC_lineCenterView" />


<!--
## Hope

* If you find bug when used，Hope you can Issues me，Thank you or try to download the latest code of this framework to see the BUG has been fixed or not）
* If you find the function is not enough when used，Hope you can Issues me，I very much to add more useful function to this framework ，Thank you !
* If you want to contribute code for EasyCharts，please Pull Requests me

-->

### RadarChartView

Initialization--Just transfer `frame`.

```swift
	var radarChartView : RadarChartView!
	radarChartView = RadarChartView.init(frame:CGRect(x: 40, y: 120, width: 280, height: 200))
	self.view.addSubview(radarChartView)
```

Data filling:

```swift
	let radarChartConfig = RadarChartConfig()
	radarChartConfig.radius = 110
	radarChartConfig.drawLineTitleList = ["Execution","Thinking","Endurance","Speed","Power","Technology"]
	radarChartConfig.drawPointList = [[(0.3),(0.6),(0.8),(0.2),(0.5),(0.3)],[(0.6),(0.1),(0.4),(0.8),(0.2),(0.9)]]
	radarChartConfig.drawLineColorList = [UIColor.orange, UIColor.red]
	radarChartView.setupRadarChartConfig(radarChartConfig: radarChartConfig)
```

```swift
	let radarChartConfig = RadarChartConfig()
	radarChartConfig.radius = 110
	radarChartConfig.drawLineTitleList = ["Execution","Thinking","Endurance","Speed","Power"]
	radarChartConfig.drawPointList = [[(0.3),(0.6),(0.8),(0.2),(0.5)]]
	radarChartConfig.drawLineColorList = [UIColor.orange]
	radarChartView.setupRadarChartConfig(radarChartConfig: radarChartConfig)
```

**The effect of PieChart:**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_RadarChart.gif"  width=300 alt="EC_lineCenterView" />


### ProgressView

Initialization--Just transfer `frame`.

```swift
self.progressView = ECProgressChartView.init(frame: CGRect(x: (ECScreenW - 200) * 0.5,
                                                                                                    y: 100,
                                                                                                   width: 200,
                                                                                                   height: 200))
self.view.addSubview(progressView!)
```

Data filling：

```swift
 let progress = CGFloat(arc4random_uniform(100)) / 100.0
 self.progressView?.resetProgress(progress: progress)
```

**The effect of ProgressView:**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_%20ProgressView_gif.gif"  width=300 alt="EC_lineCenterView" />

## Communication

* If you found a bug, and can provide steps to reliably reproduce it, open an issue.
* If you have a feature request, open an issue.
* If you want to contribute, submit a pull request.