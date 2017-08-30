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
//#import "DrawPieChartView.h"
//#import "DrawPieChartModel.h"
//#import "DrawPieChartLineView.h"
#import "ECPieChartView.h"

#define STDScreenW [UIScreen mainScreen].bounds.size.width

#define random(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface DrawCircleViewController ()

//@property (nonatomic, strong) DrawPieChartView *circleView;
//@property (nonatomic, strong) DrawPieChartLineView *lineView;

@property (nonatomic, copy) NSArray<NSNumber *> *percentList;
@property (nonatomic, copy) NSArray<UIColor *> *colorList;
@property (nonatomic, copy) NSArray<NSString *> *arcTextList;

@property (nonatomic, strong) ECPieChartView *pieView;

@end

@implementation DrawCircleViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configOwnProperties];
    [self p_configSubViews];
    [self setupTestButton];
    
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark - Functions
- (void)p_configOwnProperties {
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)p_configSubViews {
    ECPieChartView *pieView = [ECPieChartView pieChartViewWithFrame:CGRectMake(0, 100, STDScreenW, 200)];
    [self.view addSubview:pieView];
    self.pieView = pieView;
    
    [pieView drawPieChartWithPercentList:self.percentList
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

- (void)setupTestButton {
    CGFloat width = 80;
    CGFloat height = 40;
    CGFloat x = (STDScreenW - width) * 0.5;
    CGFloat y = CGRectGetMaxY(self.pieView.frame) + 180;
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [testButton setTitle:@"点击测试" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    testButton.frame = CGRectMake(x, y, width, height);
    [testButton addTarget:self
                   action:@selector(testButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
}

- (void)testButtonClicked:(UIButton *)button {
    
//    [[UIApplication sharedApplication]openURL:[NSURL   URLWithString:@"mailto:example@example.com"]];
    
    [self randomNumList];
    [self randomColorList];
    [self randomText];
    
    [self.pieView drawPieChartWithPercentList:self.percentList
                                    colorList:self.colorList
                                  arcTextList:self.arcTextList];
}

- (void)randomNumList {
    NSMutableArray *numMutableList = [NSMutableArray array];
    int sum = 0;
    while (YES) {
        int temp = arc4random_uniform(60) + 1;
        if (sum + temp >= 100 || [numMutableList count] >= 7) {
            [numMutableList addObject:@((100 - sum) / 100.0)];
            break;
        } else {
            [numMutableList addObject:@(temp / 100.0)];
            sum += temp;
        }
    }
    self.percentList = numMutableList;
}

- (void) randomColorList {
    NSMutableArray *colorMutableList = [NSMutableArray array];
    for (int i = 0; i < [self.percentList count]; i++) {
        [colorMutableList addObject:randomColor];
    }
    
    self.colorList = colorMutableList;
}

- (void)randomText {
    NSMutableArray *textMutableList = [NSMutableArray array];
    NSArray *textList = @[@"精通",@"薄弱",@"了解",@"掌握",@"weak",@"know",@"master",@"skill"];
    for (int i = 0; i < [self.percentList count]; i++) {
        [textMutableList addObject:textList[i]];
    }
    self.arcTextList = textMutableList;
}

@end
