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

@interface DrawLineView ()

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
    [self addSubview:lineCollectionView];
}

@end
