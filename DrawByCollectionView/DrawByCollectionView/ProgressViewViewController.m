//  ************************************************************************
//
//  ProgressViewViewController.m
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

#import "ProgressViewViewController.h"
#import "DrawProgressChartView.h"

#define STDScreenW [UIScreen mainScreen].bounds.size.width
@interface ProgressViewViewController ()

@property (nonatomic, strong) DrawProgressChartView *progressView;

@end

@implementation ProgressViewViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configOwnProperties];
    [self p_configSubViews];
    [self setupTestButton];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark - Functions
- (void)p_configOwnProperties {
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - HandleViews
- (void)p_configSubViews {
    [self setupDrawProgressByShapeLayer];
}

- (void)setupDrawProgressByShapeLayer {
    
    CGFloat width = 200;
    CGFloat height = 200;
    CGFloat x = (STDScreenW - width) * 0.5;
    CGFloat y = CGRectGetMaxY(self.progressView.frame) + 100;
    
    CGRect frame = CGRectMake(x ,y ,width , height);;
    DrawProgressChartView *progressView = [DrawProgressChartView progressChartViewWithFrame:frame];
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

- (CGFloat)createProgress {
    return arc4random_uniform(100) / 100.0;
}

- (void)setupTestButton {
    CGFloat width = 80;
    CGFloat height = 40;
    CGFloat x = (STDScreenW - width) * 0.5;
    CGFloat y = CGRectGetMaxY(self.progressView.frame) + 100;
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [testButton setTitle:@"点击测试" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    testButton.frame = CGRectMake(x, y, width, height);
    [testButton addTarget:self
                   action:@selector(testButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
}

- (void)testButtonClicked:(UIButton *)button {
    [self.progressView resetProgress:[self createProgress]];
}
@end
