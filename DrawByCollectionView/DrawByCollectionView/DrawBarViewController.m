//  ************************************************************************
//
//  DrawBarViewController.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/9.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawBarViewController.h"
#import "DrawBarCollectionView.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface DrawBarViewController ()



@end

@implementation DrawBarViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupNavigationBar];
    [self p_configOwnProperties];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self p_configSubViews];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark - Functions
- (void)p_setupNavigationBar {
}

- (void)p_configOwnProperties {
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - HandleViews
- (void)p_configSubViews {
    DrawBarCollectionView *barView = [DrawBarCollectionView collectionView];
    [barView setBackgroundColor:[UIColor lightGrayColor]];
    barView.frame = CGRectMake(0, 120, ScreenW, 210);
    [self.view addSubview:barView];
}

@end
