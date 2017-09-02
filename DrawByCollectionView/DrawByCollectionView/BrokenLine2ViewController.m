//  ************************************************************************
//
//  BrokenLine2ViewController.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/8/26.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "BrokenLine2ViewController.h"
#import "EasyCharts.h"

@interface BrokenLine2ViewController ()

@property (nonatomic, strong) ECBrokenLineView *brokenLineView;

@end

@implementation BrokenLine2ViewController


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
    [self.view setBackgroundColor:[UIColor colorWithRed:(240)/255.0
                                                  green:(240)/255.0
                                                   blue:(240)/255.0
                                                  alpha:1.0]];
}

#pragma mark - HandleViews
- (void)p_configSubViews {
    [self setupDrawLineView];
    [self test];
}

- (void)setupDrawLineView {
    CGRect frame = CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, 300);
    ECBrokenLineView *brokenLineView = [ECBrokenLineView lineViewWithFrame:frame
                                                       withBrokenLineConfig:nil
                                                             brokenLineType:BrokenLineTypeNormal];
    [self.view addSubview:brokenLineView];
    self.brokenLineView = brokenLineView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self test1];
}

- (void)test {
//    [self.brokenLineView reloadLineViewDataWithPointValveList:@[@"12",@"100",@"-1",@"56",@"34"]
//                                              titleText:@[@"1月",@"2月",@"3月",@"4月",@"5月"]];
    
    [self.brokenLineView reloadLineViewDataWithPointValveList:@[@"12",@"80",@"-1",@"56",@"80",@"-12",@"0",@"1",@"56",@"-14",@"12",@"80",@"1",@"56",@"34"]
                                              titleText:@[@"1月",@"2月",@"3月",@"4月",@"5月",@"1月",@"2月",@"3月",@"4月",@"5月",@"1月",@"2月",@"3月",@"4月",@"5月"]];
}

- (void)test1 {
    [self.brokenLineView reloadLineViewDataWithPointValveList:@[@"34",@"12",@"100",@"16",@"1"]
                                              titleText:@[@"1月",@"2月",@"3月",@"4月",@"5月"]];
}

@end
