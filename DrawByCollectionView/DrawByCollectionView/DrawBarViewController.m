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
#import "ECBarCollectionView.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface DrawBarViewController ()

@property (nonatomic, strong) ECBarCollectionView *barView;

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
        [self reset];
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
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - HandleViews
- (void)p_configSubViews {
    ECBarCollectionView *barView = [ECBarCollectionView collectionView];
    [barView setBackgroundColor:[UIColor whiteColor]];
    barView.frame = CGRectMake(0, 120, ScreenW, 210);
    [self.view addSubview:barView];
    self.barView = barView;
}

- (void)reset {
    NSInteger count = arc4random_uniform(3) + 1;
    [self.barView reset:count];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self reset];
}

@end
