//  ************************************************************************
//
//  EasyPieChartView.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/14.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "EasyPieChartView.h"
#import "DrawPieChartView.h"
#import "DrawPieChartLineView.h"
#import "DrawPieChartModel.h"

@interface EasyPieChartView ()

@property (nonatomic, assign) CGPoint arcCenter;
@property (nonatomic, strong) DrawPieChartView *pieChartView;
@property (nonatomic, strong) DrawPieChartLineView *pieChartLineView;

@end

@implementation EasyPieChartView

+ (instancetype)pieChartViewWithFrame:(CGRect)frame {
    EasyPieChartView *pieChartView = [[self alloc] initWithFrame:frame];
    pieChartView.arcCenter = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
    [pieChartView setupSubviews];
    return pieChartView;
}

- (void)setupSubviews {
    [self setupDrawCircleView];
    [self setupDrawCircleLineView];
    
    [self test];
}

- (void)setupDrawCircleView {
    DrawPieChartView *pieChartView = [[DrawPieChartView alloc] init];
    pieChartView.arcCenter = self.arcCenter;
    pieChartView.frame = self.frame;
    [self addSubview:pieChartView];
    self.pieChartView = pieChartView;
    
}

- (void)setupDrawCircleLineView {
    DrawPieChartLineView *pieChartLineView = [[DrawPieChartLineView alloc] init];
    pieChartLineView.arcCenter = self.arcCenter;
    pieChartLineView.frame = self.frame;
    [self addSubview:pieChartLineView];
    self.pieChartLineView = pieChartLineView;
}

//测试代码
- (void)test {
    
    NSArray *colorArray = @[[UIColor colorWithRed:(64)/255.0 green:(186)/255.0 blue:(255)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:1.0]];
    
    NSArray *arcTextArray  = @[@"精通",@"薄弱",@"了解",@"掌握"];
    
    NSMutableArray *circleModelList = [NSMutableArray array];
    
    float arr[] = {0.2,0.2,0.31,0.2};
    
    float tArr = arr[0] + arr[1] + arr[2];
    
    arr[3] = 1 - tArr;
    //    NSAssert(tArr <= 1, @"测试数组百分比 和 大于 1");
    
    CGFloat startAngle = 0;//- 2 * M_PI * arr[0];
    
    for (int i = 0 ; i < 4; i++) {
        DrawPieChartModel *model = [DrawPieChartModel circleModelWithSrartAngle:startAngle
                                                                     arcPercent:arr[i]
                                                                          color:colorArray[i]
                                                                        arcText:arcTextArray[i]
                                                                      arcCenter:self.arcCenter];
        startAngle = model.endAngle;
        [circleModelList addObject:model];
    }
    
    DrawPieChartModel *lastModel = nil;
    
    for (DrawPieChartModel *model in circleModelList) {
        if (lastModel == nil) {
            lastModel = [circleModelList lastObject];
        }
        
        if (model.arcCenterQuadrant == lastModel.arcCenterQuadrant &&
            (fabs(model.textLeftCenterPoint.y - lastModel.textLeftCenterPoint.y) < 15)) {
            [model resetLinePositionWithLastPointY:lastModel.textLeftCenterPoint.y];
        }
        
        lastModel = model;
    }
    
    
    
    
    [self.pieChartView resetCircleList:circleModelList];
    [self.pieChartLineView resetLine:circleModelList];
}

@end
