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
#import "DrawProgressView.h"
#import "DrawProgressByShapeLayer.h"

#define STDScreenW [UIScreen mainScreen].bounds.size.width
@interface ProgressViewViewController ()



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
//    [self setupProgressView];
    [self setupDrawProgressByShapeLayer];
}

//- (void)setupProgressView {
//    DrawProgressView *progressView = [[DrawProgressView alloc] init];
//    progressView.frame = CGRectMake(0, 460, 0.5 * STDScreenW, 200);
//    [self.view addSubview:progressView];
//}

- (void)setupDrawProgressByShapeLayer {
    DrawProgressByShapeLayer *progressView = [[DrawProgressByShapeLayer alloc] init];
    progressView.frame = CGRectMake(100 , 100, 0.5 * STDScreenW, 200);
    [self.view addSubview:progressView];
}

@end
