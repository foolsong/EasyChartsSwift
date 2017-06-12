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
#import "DrawCircleModel.h"
#import "DrawCircleLineView.h"

#define STDScreenW [UIScreen mainScreen].bounds.size.width
@interface DrawCircleViewController ()

@property (nonatomic, strong) DrawCircleView *circleView;
@property (nonatomic, strong) DrawCircleLineView *lineView;

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
    [self setupDrawCircleLineView];
    [self test];
}

- (void)setupDrawCircleView {
    DrawCircleView *circleView = [[DrawCircleView alloc] init];
    circleView.frame = CGRectMake(0, 240, STDScreenW, 200);
    [self.view addSubview:circleView];
    self.circleView = circleView;
    
}

- (void)setupDrawCircleLineView {
    DrawCircleLineView *lineView = [[DrawCircleLineView alloc] init];
    lineView.frame = CGRectMake(0, 240, STDScreenW, 200);
    [self.view addSubview:lineView];
    self.lineView = lineView;
}

- (void)test {
    
    float arr[] = {0.2,0.1,0.2,0.2};
    
    float tArr = arr[0] + arr[1] + arr[2];
    
    NSAssert(tArr <= 1, @"测试数组百分比 和 大于 1");
    
    CGFloat off = 0.02;
    
    DrawCircleModel *model1 = [[DrawCircleModel alloc] init];
    model1.circleColor = [UIColor colorWithRed:(64)/255.0 green:(186)/255.0 blue:(255)/255.0 alpha:1.0];
    model1.startAngle =  - 2 * M_PI * arr[0];
    model1.endAngle = model1.startAngle + 2 * M_PI * arr[0]     - off;
    model1.offestY = 100 + 76.5 * sin(model1.endAngle - (2 * M_PI * arr[0] * 0.5));
    model1.offestX = STDScreenW * 0.5 + 76.5 * cos(model1.endAngle - (M_PI * arr[0]));
    [model1 computerLinePoint];
    
    DrawCircleModel *model2 = [[DrawCircleModel alloc] init];
    model2.circleColor = [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:1.0];
    model2.startAngle = model1.endAngle   + off;
    model2.endAngle = model2.startAngle + 2 * M_PI * arr[1]  - off;
//    model2.offestY = 100 + 76.5 * sin(M_PI - model2.endAngle + (2 * M_PI * arr[1]) * 0.5);
//    model2.offestX = STDScreenW * 0.5 - 76.5 * cos(M_PI - model2.endAngle + (2 * M_PI * arr[1]) * 0.5);
    
    model2.offestY = 100 + 76.5 * sin(model2.endAngle - (M_PI * arr[1]));
    model2.offestX = STDScreenW * 0.5 + 76.5 * cos(model2.endAngle - (M_PI * arr[1]));
    [model2 computerLinePoint];
    
    DrawCircleModel *model3 = [[DrawCircleModel alloc] init];
    model3.circleColor = [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0];
    model3.startAngle = model2.endAngle + off;
    model3.endAngle = model3.startAngle + 2 * M_PI * arr[2]    - off;
//    model3.offestY = 100 + 76.5 * sin(M_PI - model3.endAngle + (2 * M_PI * arr[2]) * 0.5);
//    model3.offestX = STDScreenW * 0.5 - 76.5 * cos(M_PI - model3.endAngle + (2 * M_PI * arr[2]) * 0.5);
    
    model3.offestY = 100 + 76.5 * sin(model3.endAngle - (M_PI * arr[2]));
    model3.offestX = STDScreenW * 0.5 + 76.5 * cos(model3.endAngle - (M_PI * arr[2]));
    [model3 computerLinePoint];
    
    
    DrawCircleModel *model4 = [[DrawCircleModel alloc] init];
    model4.circleColor = [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:1.0];
    model4.startAngle = model3.endAngle + off;
    model4.endAngle = model4.startAngle + 2 * M_PI * (1 - tArr) - off;
    
//    model4.offestY = 100 + 76.5 * sin(M_PI - model4.endAngle + (2 * M_PI * (1 - tArr)) * 0.5);
//    model4.offestX = STDScreenW * 0.5 - 76.5 * cos(M_PI - model4.endAngle + (2 * M_PI * (1 - tArr)) * 0.5);
    
    model4.offestY = 100 + 76.5 * sin(model4.endAngle - (M_PI * (1 - tArr)));
    model4.offestX = STDScreenW * 0.5 + 76.5 * cos(model4.endAngle - (M_PI * (1 - tArr)));
    [model4 computerLinePoint];
    
    
    
    
    [self.circleView resetCircleList:@[model1,model2,model3,model4]];
    [self.lineView resetLine:@[model1,model2,model3,model4]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test];
}

@end
