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

@interface DrawBarCollectionView ()<UICollectionViewDelegate,
                                  UICollectionViewDataSource>



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
    
//    self.contentInset = UIEdgeInsetsMake(0, ScreenW * 0.4 , 0, ScreenW * 0.4);
}

+ (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    return layout;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 13;//[self.pointYList count];
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
}

@end
