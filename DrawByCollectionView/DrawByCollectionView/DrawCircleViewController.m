//  ************************************************************************
//
//  DrawCircleViewController.m
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

#import "DrawCircleViewController.h"
#import "DrawCircleView.h"

#define STDScreenW [UIScreen mainScreen].bounds.size.width
@interface DrawCircleViewController ()



@end

@implementation DrawCircleViewController

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
    [self setupDrawCircleView];
}

- (void)setupDrawCircleView {
    DrawCircleView *circleView = [[DrawCircleView alloc] init];
    circleView.frame = CGRectMake(0, 240, STDScreenW, 200);
    [self.view addSubview:circleView];
}

@end
