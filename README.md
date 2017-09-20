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

### Import header file


The following describes the basic use of several graphs.


### PieChart

Initialization--Just transfer `frame`.

```Objective-c
 ECPieChartView *pieView = [ECPieChartView pieChartViewWithFrame:CGRectMake(0, 100, ECScreenW, 200)];
    [self.view addSubview:pieView];
```

Data filling:Three parameters:percentList、colorList、arcTextList]

```Objective-c
[pieView drawPieChartWithPercentList:self.percentList
                               colorList:self.colorList
                             arcTextList:self.arcTextList];
```

**The effect of PieChart:**

<img src="https://github.com/foolsong/EasyCharts/blob/master/gif/EC_%20PieChart_gif.gif"  width=300 alt="EC_lineCenterView" />


<!--
## Hope

* If you find bug when used，Hope you can Issues me，Thank you or try to download the latest code of this framework to see the BUG has been fixed or not）
* If you find the function is not enough when used，Hope you can Issues me，I very much to add more useful function to this framework ，Thank you !
* If you want to contribute code for EasyCharts，please Pull Requests me

-->


## Communication

* If you found a bug, and can provide steps to reliably reproduce it, open an issue.
* If you have a feature request, open an issue.
* If you want to contribute, submit a pull request.