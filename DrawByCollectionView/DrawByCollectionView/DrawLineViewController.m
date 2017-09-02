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
#import "EasyCharts.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
@interface DrawLineViewController ()<ECBrokenLineViewDelegate>

@property (nonatomic, strong) ECBrokenLineView *brokenLineView;

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

#pragma ECBrokenLineViewDelegate
- (void)brokenLineView:(ECBrokenLineView *)brokenLineView
   selectedAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"delegate");
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
                                                            brokenLineType:BrokenLineTypeMiddlePoint];
    brokenLineView.delegate = self;
    [self.view addSubview:brokenLineView];
    self.brokenLineView = brokenLineView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test1];
}

- (void)test {
    [self.brokenLineView reloadLineViewDataWithPointValveList:@[@"12",@"90",@"-1",@"56",@"34"]
                                              titleText:@[@"Jan",@"Feb",@"Mar",@"Apr",@"May"]];
}

- (void)test1 {
    [self.brokenLineView reloadLineViewDataWithPointValveList:@[@"34",@"12",@"100",@"16",@"1"]
                                              titleText:@[@"Jan",@"Feb",@"Mar",@"Apr",@"May"]];
}


@end
