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

@property (nonatomic, copy) NSArray<NSNumber *> *percentList;
@property (nonatomic, copy) NSArray<UIColor *> *colorList;
@property (nonatomic, copy) NSArray<NSString *> *arcTextList;

@property (nonatomic, strong) NSMutableArray *pieChartModelList;

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

- (void)drawPieChartWithPercentList:(NSArray<NSNumber *> *)percentList
                          colorList:(NSArray<UIColor *> *)colorList
                        arcTextList:(NSArray<NSString *> *)arcTextList {
    self.percentList = percentList;
    self.colorList = colorList;
    self.arcTextList = arcTextList;
    if (![self isLegalOfDataList]) {
        NSAssert(NO, @"invalid data");
        return;
    }
    [self extractPieChartModelList];
    [self checkExceptionData];
    [self redrawPieChart];
}

- (BOOL)isLegalOfDataList {
    if (!([self.percentList count] == [self.colorList count] &&
          [self.colorList count] == [self.arcTextList count])) {
        return NO;
    }
    if (fabs([self computerPercentSum] - 1) > 0.001) {
        return NO;
    }
    return YES;
}

- (CGFloat)computerPercentSum {
    CGFloat sum = 0;
    for (NSNumber *num in self.percentList) {
        sum += [num floatValue];
    }
    return sum;
}

- (void)extractPieChartModelList{
    
    CGFloat startAngle = 0;//- 2 * M_PI * arr[0];
    
    for (int i = 0 ; i < [self.percentList count]; i++) {
        DrawPieChartModel *model = [DrawPieChartModel circleModelWithSrartAngle:startAngle
                                                                     arcPercent:self.percentList[i]
                                                                          color:self.colorList[i]
                                                                        arcText:self.arcTextList[i]
                                                                      arcCenter:self.arcCenter];
        startAngle = model.endAngle;
        [self.pieChartModelList addObject:model];
    }
}

- (void)checkExceptionData {
    DrawPieChartModel *lastModel = nil;
    
    for (DrawPieChartModel *model in self.pieChartModelList) {
        if (lastModel == nil) {
            lastModel = [self.pieChartModelList lastObject];
        }
        
        if (model.arcCenterQuadrant == lastModel.arcCenterQuadrant &&
            (fabs(model.textLeftCenterPoint.y - lastModel.textLeftCenterPoint.y) < 15)) {
            [model resetLinePositionWithLastPointY:lastModel.textLeftCenterPoint.y];
        }
        
        lastModel = model;
    }
}

- (void)redrawPieChart {
    [self.pieChartView resetCircleList:self.pieChartModelList];
    [self.pieChartLineView resetLine:self.pieChartModelList];
}

//测试代码
//1、拿到数据
//2、检查数据的合理性
//3、整合创建model
//4、检查是否存在极端情况
- (void)test {
    
    NSArray *colorArray = @[[UIColor colorWithRed:(64)/255.0 green:(186)/255.0 blue:(255)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(64)/255.0 green:(186)/255.0 blue:(255)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:1.0]];
    
    NSArray *arcTextArray  = @[@"精通",@"薄弱",@"了解",@"掌握",@"精通",@"薄弱",@"了解",@"掌握"];
    
    NSMutableArray *circleModelList = [NSMutableArray array];
    
    float arr[] = {0.2,0.2,0.01,0.01,0.18,0.1,0.2,0.1};
    
//    float tArr = arr[0] + arr[1] + arr[2];
//    
//    arr[3] = 1 - tArr;
    //    NSAssert(tArr <= 1, @"测试数组百分比 和 大于 1");
    
    CGFloat startAngle = 0;//- 2 * M_PI * arr[0];
    
//    for (int i = 0 ; i < 8; i++) {
//        DrawPieChartModel *model = [DrawPieChartModel circleModelWithSrartAngle:startAngle
//                                                                     arcPercent:arr[i]
//                                                                          color:colorArray[i]
//                                                                        arcText:arcTextArray[i]
//                                                                      arcCenter:self.arcCenter];
//        startAngle = model.endAngle;
//        [circleModelList addObject:model];
//    }
//    
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


#pragma mark - LazyLoads
- (NSArray *)colorList {
    if (_colorList == nil) {
        _colorList = [NSArray array];
    }
    return _colorList;
}

- (NSArray *)percentList {
    if (_percentList == nil) {
        _percentList = [NSArray array];
    }
    return _percentList;
}

- (NSArray *)arcTextList {
    if (_arcTextList == nil) {
        _arcTextList = [NSArray array];
    }
    return _arcTextList;
}

- (NSMutableArray *)pieChartModelList {
    if (_pieChartModelList == nil) {
        _pieChartModelList = [NSMutableArray array];
    }
    return _pieChartModelList;
}

@end
