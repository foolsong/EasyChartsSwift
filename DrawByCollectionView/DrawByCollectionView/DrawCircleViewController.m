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

#define STDScreenW [UIScreen mainScreen].bounds.size.width
@interface DrawCircleViewController ()

@property (nonatomic, strong) DrawCircleView *circleView;

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
    self.circleView = circleView;
}

- (void)test {
    
    CGFloat off = 0.02;
    
    DrawCircleModel *model1 = [[DrawCircleModel alloc] init];
    model1.circleColor = [UIColor colorWithRed:(64)/255.0 green:(186)/255.0 blue:(255)/255.0 alpha:1.0];
    model1.startAngle = -M_PI_2;
    model1.endAngle = model1.startAngle + M_PI * 0.2     - off;
    
    DrawCircleModel *model2 = [[DrawCircleModel alloc] init];
    model2.circleColor = [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:1.0];
    model2.startAngle = model1.endAngle   + off;
    model2.endAngle = model2.startAngle + M_PI * 0.4  - off;
    
    DrawCircleModel *model3 = [[DrawCircleModel alloc] init];
    model3.circleColor = [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0];
    model3.startAngle = model2.endAngle + off;
    model3.endAngle = model3.startAngle + M_PI * 1.1    - off;
    
    DrawCircleModel *model4 = [[DrawCircleModel alloc] init];
    model4.circleColor = [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:1.0];
    model4.startAngle = model3.endAngle + off;
    model4.endAngle = model4.startAngle + M_PI * 0.3 - off;
    
    
    
    
    [self.circleView resetCircleList:@[model1,model2,model3,model4]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test];
}

@end
