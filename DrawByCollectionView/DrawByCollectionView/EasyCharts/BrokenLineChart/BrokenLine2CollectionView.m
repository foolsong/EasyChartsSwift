//  ************************************************************************
//
//  BrokenLine2CollectionViewController.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/8/26.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "BrokenLine2CollectionView.h"
#import "DrawLineCollectionViewCell.h"
#import "ECBrokenLinePointModel.h"
#import "CommonColor.h"
#import "ECBrokenLineConfig.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface BrokenLine2CollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

//@property (nonatomic, strong) DrawLineCollectionViewCell *currentCell;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, strong) ECBrokenLineConfig *brokenLineConfig;

@end

@implementation BrokenLine2CollectionView

+ (instancetype)collectionViewWithFrame:(CGRect)frame
                   withBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig {
    BrokenLine2CollectionViewFlowLayout *layout = [self collectionViewFlowLayout];
    BrokenLine2CollectionView *collectionView =
    [[self alloc]initWithFrame:CGRectMake(35, 0,frame.size.width - 35 ,frame.size.height)
          collectionViewLayout:layout];
    collectionView.brokenLineConfig = brokenLineConfig;
    [collectionView registerClass:[DrawLineCollectionViewCell class] forCellWithReuseIdentifier:@"DrawLineCollectionViewCell"];
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
- (void)reloadCollectionData {
    [self reloadData];
    [self scrollToRightmostCell];
}

- (void)scrollToRightmostCell {
    CGFloat offsetX = ([[self pointModelList] count] - 3) * self.cellWidth + 0.2 * 2;
    self.contentOffset = CGPointMake(offsetX, 0);
    self.currentIndex = [[self pointModelList] count] - 1;
}

- (void)p_configOwnProperties {
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.dataSource = self;
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    self.contentInset = UIEdgeInsetsMake(0, self.cellWidth * 2 , 0, self.cellWidth * 2);
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_drawLineDelegate && [_drawLineDelegate respondsToSelector:@selector(collectionViewPointYList:
                                                                             didSelectItemAtIndexPath:)]) {
        [_drawLineDelegate collectionViewPointYList:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - CollectionViewFlowLayout
+ (BrokenLine2CollectionViewFlowLayout *)collectionViewFlowLayout {
    BrokenLine2CollectionViewFlowLayout *layout = [BrokenLine2CollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    return layout;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self pointModelList] count];
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DrawLineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DrawLineCollectionViewCell" forIndexPath:indexPath];
    [cell setItemSize:[self sizeForItemAtIndexPath:indexPath]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self sizeForItemAtIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [(DrawLineCollectionViewCell *)cell setupBrokenLineConfig:self.brokenLineConfig];
    [(DrawLineCollectionViewCell *)cell configureCellWithPointYList:[self pointModelList] withIndex:indexPath.row];
    if (self.currentIndex == indexPath.row) {
        [(DrawLineCollectionViewCell *)cell setupCellSelected:YES];
    } else {
        [(DrawLineCollectionViewCell *)cell setupCellSelected:NO];
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
    [self reloadData];
    
    if (_drawLineDelegate && [_drawLineDelegate respondsToSelector:@selector(collectionViewPointYList:
                                                                             didSelectItemAtIndexPath:)]) {
        [_drawLineDelegate collectionViewPointYList:self didSelectItemAtIndexPath:indexPath];
    }
}

- (NSArray *)pointModelList {
    NSArray * pointModelList;
    if (_drawLineDataSource && [_drawLineDataSource respondsToSelector:@selector(collectionViewPointYList:)]) {
        pointModelList = [_drawLineDataSource collectionViewPointYList:self];
    } else {
        NSAssert(NO, @"添加数据源");
    }
    return pointModelList;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath  {
    if (_drawLineDataSource &&
        [_drawLineDataSource respondsToSelector:@selector(collectionView:
                                                          sizeForItemAtIndexPath:)]) {
        return [_drawLineDataSource collectionView:self sizeForItemAtIndexPath:indexPath];
    }
    NSAssert(NO, @"需添加折线图的size");
    return CGSizeZero;
}

- (CGFloat)cellWidth {
    return (self.frame.size.width) * 0.2 + 0.2;
}

@end
#pragma mark - collectionView 的 flowLayout
/**
 collectionView 的 flowLayout
 */
@interface BrokenLine2CollectionViewFlowLayout()

@end

@implementation BrokenLine2CollectionViewFlowLayout

@end
