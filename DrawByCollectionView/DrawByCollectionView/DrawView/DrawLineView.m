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
#import "DrawLineBackgroundView.h"
#import "PointViewModel.h"

@interface DrawLineView ()<DrawLineCollectionViewDataSource>

@property (nonatomic, strong) DrawLineCollectionView *lineCollectionView;
@property (nonatomic, copy) NSArray <PointViewModel *>*pointModelList;
@property (nonatomic, assign) CGSize lineViewSize;

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
    lineView.frame = frame;
    [lineView setupSubviews];
    return lineView;
}

- (void)setupSubviews {
    [self setupBackgroundViewWithFrame:self.frame];
    [self setupCollectionView];
}

- (void)setupBackgroundViewWithFrame:(CGRect) frame {
    DrawLineBackgroundView *backgroupView = [DrawLineBackgroundView backgroundViewWithFrame:frame];
    [self addSubview:backgroupView];
}

- (void)setupCollectionView {
    DrawLineCollectionView *lineCollectionView =
    [DrawLineCollectionView collectionViewWithFrame:self.frame];
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
    [self.lineCollectionView reloadCollectionData];
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

@end
