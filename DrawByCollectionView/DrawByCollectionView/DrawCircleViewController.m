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
    
    NSArray *colorArray = @[[UIColor colorWithRed:(64)/255.0 green:(186)/255.0 blue:(255)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:1.0]];
    
    NSArray *arcTextArray  = @[@"精通",@"薄弱",@"了解",@"掌握"];
    
    NSMutableArray *circleModelList = [NSMutableArray array];
    
    float arr[] = {0.31,0.21,0.11,0.2};
    
    float tArr = arr[0] + arr[1] + arr[2];
    
    arr[3] = 1 - tArr;
    NSAssert(tArr <= 1, @"测试数组百分比 和 大于 1");
    
    CGFloat startAngle = - 2 * M_PI * arr[0];
    
    for (int i = 0 ; i < 4; i++) {
        DrawCircleModel *model = [DrawCircleModel circleModelWithSrartAngle:startAngle
                                                                   arcPercent:arr[i]
                                                                      color:colorArray[i]
                                                                    arcText:arcTextArray[i]];
        startAngle = model.endAngle;
        [circleModelList addObject:model];
    }

    [self.circleView resetCircleList:circleModelList];
    [self.lineView resetLine:circleModelList];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test];
}

@end
