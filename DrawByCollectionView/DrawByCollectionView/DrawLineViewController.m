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
#import "DrawLineView.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
@interface DrawLineViewController ()

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - HandleViews
- (void)p_configSubViews {
    [self setupDrawLineView];
}

- (void)setupDrawLineView {
    CGRect frame = CGRectMake(0, 120, ScreenW, 210);
    DrawLineView *lineView = [DrawLineView lineViewWithFrame:frame];
    [self.view addSubview:lineView];
}


@end
