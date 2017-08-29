//  ************************************************************************
//
//  DrawLineView.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawLineView.h"
#import "DrawLineCollectionView.h"
#import "BrokenLine2CollectionView.h"
#import "DrawLineBackgroundView.h"
#import "PointViewModel.h"
#import "BrokenLineBackgroundView.h"

#import "DrawConfig.h"

@interface DrawLineView ()<DrawLineCollectionViewDataSource,BrokenLine2CollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *lineCollectionView;
@property (nonatomic, copy) NSArray <PointViewModel *>*pointModelList;
@property (nonatomic, assign) CGSize lineViewSize;
@property (nonatomic, strong) DrawConfig *drawConfig;
@property (nonatomic, assign) BrokenLineType brokenLineType;

@end

@implementation DrawLineView

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (instancetype)lineViewWithFrame:(CGRect) frame {
    DrawLineView *lineView = [[self alloc] init];
    lineView.brokenLineType = BrokenLineTypeMiddlePoint;
    lineView.drawConfig = nil;
    lineView.frame = frame;
    [lineView setupSubviews];
    return lineView;
}

+ (instancetype)lineView2WithFrame:(CGRect) frame
                    withDrawConfig:(DrawConfig *)drawConfig
                    brokenLineType:(BrokenLineType)brokenLineType {
    DrawLineView *lineView = [[self alloc] init];
    lineView.brokenLineType = brokenLineType;
    lineView.drawConfig = drawConfig;
    lineView.frame = frame;
    [lineView setupSubviews2];
    return lineView;
}

- (void)setupSubviews {
    [self setupBackgroundViewWithFrame:self.frame];
    [self setupCollectionView];
}

- (void)setupSubviews2 {
    BrokenLineBackgroundView *backgroupView =
    [BrokenLineBackgroundView lineBackgroundViewWithFrame:self.bounds
                                           withDrawConfig:self.drawConfig];
    [self addSubview:backgroupView];
    [self setupBrokenLine2CollectionView];
}

- (void)setupBackgroundViewWithFrame:(CGRect) frame {
    DrawLineBackgroundView *backgroupView = [DrawLineBackgroundView backgroundViewWithFrame:frame];
    [self addSubview:backgroupView];
}

- (void)setupBrokenLine2CollectionView {
    BrokenLine2CollectionView *lineCollectionView =
    [BrokenLine2CollectionView collectionViewWithFrame:self.frame
                                        withDrawConfig:self.drawConfig];
    lineCollectionView.drawLineDataSource = self;
    self.lineCollectionView = lineCollectionView;
    [self addSubview:lineCollectionView];
}

- (void)setupCollectionView {
    DrawLineCollectionView *lineCollectionView =
    [DrawLineCollectionView collectionViewWithFrame:self.frame withDrawConfig:self.drawConfig];
    lineCollectionView.drawLineDataSource = self;
    self.lineCollectionView = lineCollectionView;
    [self addSubview:lineCollectionView];
}

- (NSArray *)collectionViewPointYList:(DrawLineCollectionView *)collectionView {
    return self.pointModelList;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemW = self.frame.size.width * 0.2 + 0.2;
    return CGSizeMake(itemW, self.frame.size.height);
}

- (void)reloadLineViewDataWithPointValveList:(NSArray *)pointValueList
                                   titleText:(NSArray *)titleTextList{
    [self computerAndCombinationModelListWithPointValveList:pointValueList
                                                  titleText:titleTextList];
#warning TODO
//    [self.lineCollectionView reloadCollectionData];
}

#pragma mark - computer pointY
- (void)computerAndCombinationModelListWithPointValveList:(NSArray *)pointValueList
                                                titleText:(NSArray *)titleTextList {
    NSMutableArray *modelMutableArray = [NSMutableArray array];
    for (int i = 0; i < [pointValueList count]; i++) {
        NSString *numString = pointValueList[i];
        NSString *lastNumString = [self numStringWithIndex:i - 1 pointValveList:pointValueList];
        NSString *nextNumString = [self numStringWithIndex:i + 1 pointValveList:pointValueList];;
        
        PointViewModel *pointModel = [[PointViewModel alloc] init];
        pointModel.leftLineType = [self lineTypeWithNumString:numString nearNumString:lastNumString];
        pointModel.rightLineType = [self lineTypeWithNumString:numString nearNumString:nextNumString];
        pointModel.pointY = [@"-1" isEqualToString:numString] ? @"0" : [NSString stringWithFormat:@"%f",[numString floatValue]];
        pointModel.titleText = titleTextList[i];
        pointModel.pointY = [NSString stringWithFormat:@"%f",15 + (1 - ([pointModel.pointY floatValue]/100)) * (self.frame.size.height - 40)];
        [modelMutableArray addObject:pointModel];
    }
    self.pointModelList = [modelMutableArray copy];
}

- (LineType)lineTypeWithNumString:(NSString *) numString nearNumString:(NSString *) nearNumString{
    if (nearNumString == nil) {
        return  LineTypeNoline;
    } else if ([@"-1" isEqualToString:nearNumString] || [@"-1" isEqualToString:numString]) {
        return LineTypeDotted;
    } else {
        return LineTypeNormal;
    }
}

- (NSString *)numStringWithIndex:(NSInteger)index
                  pointValveList:(NSArray *)pointValueList{
    if (index < 0 || index >= [pointValueList count]) {
        return nil;
    } else {
        return pointValueList[index];
    }
}

- (NSArray<PointViewModel *> *)pointModelList {
    if (_pointModelList == nil) {
        _pointModelList = [NSArray array];
    }
    return _pointModelList;
}

- (DrawConfig *)drawConfig {
    if (_drawConfig == nil) {
        _drawConfig = [DrawConfig drawConfigWithBrokenLineType:self.brokenLineType];
    }
    return _drawConfig;
}

@end
