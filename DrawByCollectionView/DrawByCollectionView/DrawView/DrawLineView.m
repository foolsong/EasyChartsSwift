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
#import "XZMRefresh.h"

@interface DrawLineView ()

@property (nonatomic, strong) DrawLineCollectionView *lineCollectionView;

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
    self.lineCollectionView = lineCollectionView;
    [self addSubview:lineCollectionView];
    [lineCollectionView xzm_addNormalHeaderWithTarget:self action:@selector(loadNewDataWithHeader:)];
}

- (void)loadNewDataWithHeader:(XZMRefreshHeader *)header
{
    // 增加1条假数据
    
    // 模拟延迟加载数据，因此2秒后才调用）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.lineCollectionView reloadData];
        // 结束刷新
        [header endRefreshing];
    });
}

@end
