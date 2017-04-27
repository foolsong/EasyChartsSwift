//
//  ViewController.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import "ViewController.h"
#import "DrawLineView.h"
#define STDScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDrawLineView];
    
}

- (void)setupDrawLineView {
    DrawLineView *lineView = [[DrawLineView alloc] init];
    lineView.frame = CGRectMake(0, 120, STDScreenW, 100);
    [self.view addSubview:lineView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
