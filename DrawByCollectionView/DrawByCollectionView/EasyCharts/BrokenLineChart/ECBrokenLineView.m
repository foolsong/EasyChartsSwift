//  ************************************************************************
//
//  ECBrokenLineView.m
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

#import "ECBrokenLineView.h"
#import "DrawLineCollectionView.h"
#import "BrokenLine2CollectionView.h"
#import "DrawLineBackgroundView.h"
#import "ECBrokenLinePointModel.h"
#import "BrokenLineBackgroundView.h"

#import "ECBrokenLineConfig.h"

@interface ECBrokenLineView ()<DrawLineCollectionViewDataSource,BrokenLine2CollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *lineCollectionView;
@property (nonatomic, copy) NSArray <ECBrokenLinePointModel *>*pointModelList;
@property (nonatomic, assign) CGSize lineViewSize;
@property (nonatomic, strong) ECBrokenLineConfig *brokenLineConfig;
@property (nonatomic, assign) BrokenLineType brokenLineType;

@end

@implementation ECBrokenLineView

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (instancetype)lineViewWithFrame:(CGRect) frame {
    ECBrokenLineView *lineView = [[self alloc] init];
    lineView.brokenLineType = BrokenLineTypeMiddlePoint;
    lineView.brokenLineConfig = nil;
    lineView.frame = frame;
    [lineView setupSubviews];
    return lineView;
}

+ (instancetype)lineView2WithFrame:(CGRect) frame
              withBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig
                    brokenLineType:(BrokenLineType)brokenLineType {
    ECBrokenLineView *lineView = [[self alloc] init];
    lineView.brokenLineType = brokenLineType;
    lineView.brokenLineConfig = brokenLineConfig;
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
                                           withBrokenLineConfig:self.brokenLineConfig];
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
                                        withBrokenLineConfig:self.brokenLineConfig];
    lineCollectionView.drawLineDataSource = self;
    self.lineCollectionView = lineCollectionView;
    [self addSubview:lineCollectionView];
}

- (void)setupCollectionView {
    DrawLineCollectionView *lineCollectionView =
    [DrawLineCollectionView collectionViewWithFrame:self.frame withDrawConfig:self.brokenLineConfig];
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
        
        ECBrokenLinePointModel *pointModel = [[ECBrokenLinePointModel alloc] init];
        pointModel.leftLineType = [self lineTypeWithNumString:numString nearNumString:lastNumString];
        pointModel.rightLineType = [self lineTypeWithNumString:numString nearNumString:nextNumString];
        
        if ([numString floatValue] > self.brokenLineConfig.maxValue) {
            pointModel.pointY = [NSString stringWithFormat:@"%f",self.brokenLineConfig.maxValue];
        } else if ([numString floatValue] < self.brokenLineConfig.minValue) {
            pointModel.pointY = [NSString stringWithFormat:@"%f",self.brokenLineConfig.minValue];
        } else {
            pointModel.pointY = [NSString stringWithFormat:@"%f",[numString floatValue]];
        }
        
        pointModel.titleText = titleTextList[i];
        pointModel.pointY = [NSString stringWithFormat:@"%f",15 + (1 - (([pointModel.pointY floatValue] - self.brokenLineConfig.minValue)/(self.brokenLineConfig.maxValue - self.brokenLineConfig.minValue))) * (self.frame.size.height - 40)];
        [modelMutableArray addObject:pointModel];
    }
    self.pointModelList = [modelMutableArray copy];
}

- (LineType)lineTypeWithNumString:(NSString *) numString nearNumString:(NSString *) nearNumString{
    if (nearNumString == nil) {
        return  LineTypeNoline;
    } else if ([self isDottedLineWithNumString:numString nearNumString:nearNumString]) {
        return LineTypeDotted;
    } else {
        return LineTypeNormal;
    }
    
}

- (BOOL)isDottedLineWithNumString:(NSString *) numString nearNumString:(NSString *) nearNumString {
    return [nearNumString floatValue] > self.brokenLineConfig.maxValue ||
            [nearNumString floatValue] < self.brokenLineConfig.minValue ||
            [numString floatValue] > self.brokenLineConfig.maxValue ||
            [numString floatValue] < self.brokenLineConfig.minValue;
}

- (NSString *)numStringWithIndex:(NSInteger)index
                  pointValveList:(NSArray *)pointValueList{
    if (index < 0 || index >= [pointValueList count]) {
        return nil;
    } else {
        return pointValueList[index];
    }
}

- (NSArray<ECBrokenLinePointModel *> *)pointModelList {
    if (_pointModelList == nil) {
        _pointModelList = [NSArray array];
    }
    return _pointModelList;
}

- (ECBrokenLineConfig *)brokenLineConfig {
    if (_brokenLineConfig == nil) {
        _brokenLineConfig = [ECBrokenLineConfig configWithBrokenLineType:self.brokenLineType];
    }
    return _brokenLineConfig;
}

@end
