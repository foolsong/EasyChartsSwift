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

@interface DrawLineView ()<DrawLineCollectionViewDataSource>

@property (nonatomic, strong) DrawLineCollectionView *lineCollectionView;
@property (nonatomic, copy) NSArray *pointYList;

@end

@implementation DrawLineView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupCollectionView];
    }
    return self;
}

- (void)setupCollectionView {
    DrawLineCollectionView *lineCollectionView = [DrawLineCollectionView collectionView];
    lineCollectionView.drawLineDataSource = self;
    self.lineCollectionView = lineCollectionView;
    [self addSubview:lineCollectionView];
}

- (NSArray *)collectionViewPointYList:(DrawLineCollectionView *)collectionView {
    return self.pointYList;
}

- (NSArray *)pointYList {
    if (_pointYList == nil) {
        _pointYList = @[@"12",@"51",@"-1",@"73",@"27",@"63",@"12",@"51",@"-1",@"-1",@"27",@"93"];
    }
    return _pointYList;
}

@end
