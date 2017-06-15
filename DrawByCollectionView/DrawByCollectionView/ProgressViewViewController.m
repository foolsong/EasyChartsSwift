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
    DrawProgressChartView *progressView = [[DrawProgressChartView alloc] init];
    progressView.frame = CGRectMake(100 , 100, 0.5 * STDScreenW, 200);
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.progressView resetProgress:[self createProgress]];
}

- (CGFloat)createProgress {
    return arc4random_uniform(100) / 100.0;
}


@end
