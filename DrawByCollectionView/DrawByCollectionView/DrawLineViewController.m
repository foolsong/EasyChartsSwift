//  ************************************************************************
//
//  DrawLineViewController.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/6.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawLineViewController.h"
#import "EasyCharts.h"

@interface DrawLineViewController ()<ECBrokenLineViewDelegate>

@property (nonatomic, strong) ECBrokenLineView *brokenLineView;
@property (nonatomic, strong) ECProgressChartView *progressView;
@property (nonatomic, copy) NSArray *pointValveList;

@end

@implementation DrawLineViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configOwnProperties];
    [self p_configSubViews];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark - Functions
- (void)p_configOwnProperties {
//    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view setBackgroundColor:[UIColor colorWithRed:(255)/255.0
                                             green:(156)/255.0
                                              blue:(14)/255.0
                                             alpha:1.0]];
}

#pragma ECBrokenLineViewDelegate
- (void)brokenLineView:(ECBrokenLineView *)brokenLineView
   selectedAtIndexPath:(NSIndexPath *)indexPath {
    [self.progressView resetProgress:([self.pointValveList[indexPath.row] floatValue]) / 100.0];
}

#pragma mark - HandleViews
- (void)p_configSubViews {
    [self setupDrawProgressByShapeLayer];
    [self setupDrawLineView];
    
    [self test];
}

- (void)setupDrawProgressByShapeLayer {
    
    CGFloat width = 150;
    CGFloat height = 150;
    CGFloat x = (ECScreenW - width) * 0.5;
    CGFloat y = CGRectGetMaxY(self.progressView.frame) + 100;
    
    CGRect frame = CGRectMake(x ,y ,width , height);;
    ECProgressChartView *progressView = [ECProgressChartView progressChartViewWithFrame:frame];
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

- (void)setupDrawLineView {
    CGRect frame = CGRectMake(0, 280, [UIScreen mainScreen].bounds.size.width, 300);
    ECBrokenLineView *brokenLineView = [ECBrokenLineView lineViewWithFrame:frame
                                                      withBrokenLineConfig:nil
                                                            brokenLineType:BrokenLineTypeMiddlePoint];
    brokenLineView.delegate = self;
    [self.view addSubview:brokenLineView];
    self.brokenLineView = brokenLineView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test1];
}

- (void)test {
    [self.brokenLineView reloadLineViewDataWithPointValveList:self.pointValveList
                                              titleText:@[@"Jan",@"Feb",@"Mar",@"Apr",@"May"]];
}

- (void)test1 {
    self.pointValveList = @[@"34",@"12",@"100",@"16",@"1"];
    [self.brokenLineView reloadLineViewDataWithPointValveList: self.pointValveList
                                              titleText:@[@"Jan",@"Feb",@"Mar",@"Apr",@"May"]];
}

- (NSArray *)pointValveList {
    if (_pointValveList == nil) {
        _pointValveList = @[@"12",@"90",@"0",@"56",@"34"];
    }
    return _pointValveList;
}

@end
