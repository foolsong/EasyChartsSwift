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

@interface DrawLineView ()<DrawLineCollectionViewDataSource>

@property (nonatomic, strong) DrawLineCollectionView *lineCollectionView;
@property (nonatomic, copy) NSArray *pointYList;
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
    return self.pointYList;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemW = self.frame.size.width * 0.2 + 0.2;
    return CGSizeMake(itemW, 210);
}

- (NSArray *)pointYList {
    if (_pointYList == nil) {
        _pointYList = @[@"12",@"-1",@"68",@"73",@"27",@"63",@"12",@"51",@"-1",@"-1",@"27",@"93",@"100"];
    }
    return _pointYList;
}

@end
