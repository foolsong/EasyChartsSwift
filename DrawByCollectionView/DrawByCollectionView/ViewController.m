//
//  ViewController.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import "ViewController.h"
#import "DrawLineView.h"
#import "DottedLineView.h"
#import "DrawCircleView.h"
#import "DrawProgressView.h"

#define STDScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setDottedLineView];
    
    [self setupDrawLineView];
    
    [self setupDrawCircleView];
    
    [self setupProgressView];
    
}

- (void)setDottedLineView {
    DottedLineView *dottedLineView = [[DottedLineView alloc] init];
    
    dottedLineView.frame = CGRectMake(0, 100, STDScreenW, 200);
    
    [self.view addSubview:dottedLineView];
}

- (void)setupDrawLineView {
    DrawLineView *lineView = [[DrawLineView alloc] init];
    lineView.frame = CGRectMake(0, 20, STDScreenW, 200);
    [self.view addSubview:lineView];
}

- (void)setupDrawCircleView {
    DrawCircleView *circleView = [[DrawCircleView alloc] init];
    circleView.frame = CGRectMake(0, 240, STDScreenW, 200);
    [self.view addSubview:circleView];
}

- (void)setupProgressView {
    DrawProgressView *progressView = [[DrawProgressView alloc] init];
    progressView.frame = CGRectMake(0, 460, STDScreenW, 200);
    [self.view addSubview:progressView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
