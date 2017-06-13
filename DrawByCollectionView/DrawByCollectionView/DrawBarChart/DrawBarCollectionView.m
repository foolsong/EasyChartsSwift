//  ************************************************************************
//
//  DrawBarCollectionView.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/9.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawBarCollectionView.h"
#import "DrawBarCollectionViewCell.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface DrawBarCollectionView ()<UICollectionViewDelegate,
                                  UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger cellCount;

@end

@implementation DrawBarCollectionView

+ (instancetype)collectionView {
    DrawBarCollectionView *collectionView =
    [[self alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width ,210)
          collectionViewLayout:[self collectionViewFlowLayout]];
    [collectionView registerClass:[DrawBarCollectionViewCell class] forCellWithReuseIdentifier:@"DrawBarCollectionViewCell"];
    return collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(nonnull UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self p_configOwnProperties];
    }
    return self;
}

#pragma mark - functions
- (void)p_configOwnProperties {
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.dataSource = self;
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
//    self.contentInset = UIEdgeInsetsMake(0, ScreenW * 0.25 , 0, ScreenW * 0.25);
    
//    self.contentOffset = CGPointMake( -ScreenW * 0.5 + 78 * 0.5, 0);
}

+ (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    return layout;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cellCount;//[self.pointYList count];
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DrawBarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DrawBarCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(87, 200);
}

//-(CGFloat )collectionView:(UICollectionView *)collectionView
//                   layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 0.01;
//}

//-(CGFloat )collectionView:(UICollectionView *)collectionView
//                   layout:(nonnull UICollectionViewLayout *)collectionViewLayout
//minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 0.01;
//}

#pragma mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    [(DrawBarCollectionViewCell *)cell configureCellWithPointYList:self.pointModelLits withIndex:indexPath.row];
    [(DrawBarCollectionViewCell *)cell reset];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat cellWidth = (ScreenW / 5.0);
//    CGFloat offsetX = (indexPath.row - 2) * cellWidth;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.contentOffset = CGPointMake(offsetX, 0);
//    }];
//    self.contentOffset = CGPointMake(-ScreenW * 0.5, 0);
    
}


- (void)reset:(NSInteger)cellCount {
    _cellCount = cellCount;
    [self reloadData];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.contentOffset = CGPointMake( -ScreenW * 0.5 + 87 * 0.5 * cellCount, 0);
    });
    
    NSLog(@"%ld -      %f",(long)cellCount,-ScreenW * 0.5 + 87 * 0.5 * cellCount);
    
//    [self layoutIfNeeded];
}

@end