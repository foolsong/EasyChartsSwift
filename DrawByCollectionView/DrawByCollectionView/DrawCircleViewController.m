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
#import "DrawPieChartView.h"
#import "DrawPieChartModel.h"
#import "DrawPieChartLineView.h"
#import "EasyPieChartView.h"

#define STDScreenW [UIScreen mainScreen].bounds.size.width
@interface DrawCircleViewController ()

@property (nonatomic, strong) DrawPieChartView *circleView;
@property (nonatomic, strong) DrawPieChartLineView *lineView;

@property (nonatomic, copy) NSArray<NSNumber *> *percentList;
@property (nonatomic, copy) NSArray<UIColor *> *colorList;
@property (nonatomic, copy) NSArray<NSString *> *arcTextList;

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

- (void)p_configSubViews {
    EasyPieChartView *view = [EasyPieChartView pieChartViewWithFrame:CGRectMake(0, 100, STDScreenW, 200)];
    [self.view addSubview:view];
    
    [view drawPieChartWithPercentList:self.percentList
                            colorList:self.colorList
                          arcTextList:self.arcTextList];
}

- (NSArray<NSNumber *> *)percentList {
    if (_percentList == nil) {
        _percentList = @[@(0.2),@(0.4),@(0.1),@(0.3)];
    }
    return _percentList;
}

- (NSArray<UIColor *> *)colorList {
    if (_colorList == nil) {
        _colorList = @[[UIColor colorWithRed:(64)/255.0 green:(186)/255.0 blue:(255)/255.0 alpha:1.0],
                       [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:1.0],
                       [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0],
                       [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:1.0]];
    }
    return _colorList;
}

- (NSArray<NSString *> *)arcTextList {
    if (_arcTextList == nil) {
        _arcTextList = @[@"精通",@"薄弱",@"了解",@"掌握"];
    }
    return _arcTextList;
}

/*
 
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
 
 */

/*
#pragma mark - HandleViews
- (void)p_configSubViews {
    [self setupDrawCircleView];
    [self setupDrawCircleLineView];
    [self test];
}

- (void)setupDrawCircleView {
    DrawPieChartView *circleView = [[DrawPieChartView alloc] init];
    circleView.frame = CGRectMake(0, 240, STDScreenW, 200);
    [self.view addSubview:circleView];
    self.circleView = circleView;
    
}

- (void)setupDrawCircleLineView {
    DrawPieChartLineView *lineView = [[DrawPieChartLineView alloc] init];
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
    
    float arr[] = {0.2,0.2,0.31,0.2};
    
    float tArr = arr[0] + arr[1] + arr[2];
    
    arr[3] = 1 - tArr;
//    NSAssert(tArr <= 1, @"测试数组百分比 和 大于 1");
    
    CGFloat startAngle = 0;//- 2 * M_PI * arr[0];
    
    for (int i = 0 ; i < 2; i++) {
        DrawPieChartModel *model = [DrawPieChartModel circleModelWithSrartAngle:startAngle
                                                                   arcPercent:arr[i]
                                                                      color:colorArray[i]
                                                                    arcText:arcTextArray[i]];
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
    
    
    

    [self.circleView resetCircleList:circleModelList];
    [self.lineView resetLine:circleModelList];
}


- (void)test2 {
    
    NSArray *colorArray = @[[UIColor colorWithRed:(64)/255.0 green:(186)/255.0 blue:(255)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:1.0]];
    
    NSArray *arcTextArray  = @[@"精通",@"薄弱",@"了解",@"掌握"];
    
    NSMutableArray *circleModelList = [NSMutableArray array];
    
    float arr[] = {0.21,0.3,0.11,0.2};
    
    float tArr = arr[0] + arr[1] + arr[2];
    
    arr[3] = 1 - tArr;
    NSAssert(tArr <= 1, @"测试数组百分比 和 大于 1");
    
    CGFloat startAngle = 0;//- 2 * M_PI * arr[0];
    
    for (int i = 0 ; i < 4; i++) {
        DrawPieChartModel *model = [DrawPieChartModel circleModelWithSrartAngle:startAngle
                                                                 arcPercent:arr[i]
                                                                      color:colorArray[i]
                                                                    arcText:arcTextArray[i]];
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
    
    
    
    
    [self.circleView resetCircleList:circleModelList];
    [self.lineView resetLine:circleModelList];
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self testAll];
    });
    
}

- (void)testAll {
    
    dispatch_async(dispatch_get_global_queue(0, NO), ^{
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 56; i <= 100; i ++) {
            for (int j = 0; j <= 100; j ++) {
                for (int k = 0; k <= 100; k++) {
                    if (i + j + k <= 100) {
                        int m = 100 - (i + j + k);
                        if (i > 0) {
                            [array addObject:@(i)];
                        }
                        if (j > 0) {
                            [array addObject:@(j)];
                        }
                        if (k > 0) {
                            [array addObject:@(k)];
                        }
                        if (m > 0) {
                            [array addObject:@(m)];
                        }
                        
                        
                        dispatch_async(dispatch_get_main_queue(),^{
                            
                            //想要在主线程中执行的代码 如刷新UI
                            [self testt:array];
                            
                        });
                        
                        [NSThread sleepForTimeInterval:.1];
                        [array removeAllObjects];
                    }
                }
            }
        }
    });
    
   
}




- (void)testt:(NSMutableArray *)muArr {
    
    
    
    NSArray *colorArray = @[[UIColor colorWithRed:(64)/255.0 green:(186)/255.0 blue:(255)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0],
                            [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:1.0]];
    
    NSArray *arcTextArray  = @[@"精通",@"薄弱",@"了解",@"掌握"];
    
    NSMutableArray *circleModelList = [NSMutableArray array];
    
    float arr[] = {0.01,0.97,0.01,0.2};
    
    for (int i = 0; i < [muArr count]; i ++) {
        arr[i] = [muArr[i] intValue] / 100.0;
    }
    
//    NSAssert(tArr <= 1, @"测试数组百分比 和 大于 1");
    
    CGFloat startAngle = 0;//- 2 * M_PI * arr[0];
    
    for (int i = 0 ; i < [muArr count]; i++) {
        DrawPieChartModel *model = [DrawPieChartModel circleModelWithSrartAngle:startAngle
                                                                 arcPercent:arr[i]
                                                                      color:colorArray[i]
                                                                    arcText:arcTextArray[i]];
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
    
    
    
    
    [self.circleView resetCircleList:circleModelList];
    [self.lineView resetLine:circleModelList];
}*/
@end
