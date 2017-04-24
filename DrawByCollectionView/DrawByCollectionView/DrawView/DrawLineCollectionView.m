//  ************************************************************************
//
//  DrawLineCollectionView.m
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

#import "DrawLineCollectionView.h"
#import "DrawLineCollectionViewCell.h"
#define STDScreenW [UIScreen mainScreen].bounds.size.width

@interface DrawLineCollectionView ()<UICollectionViewDelegate,
                                   UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *pointXList;

@end

@implementation DrawLineCollectionView
+ (instancetype)collectionView {
    DrawLineCollectionView *collectionView =
    [[self alloc]initWithFrame:CGRectMake(0, 0,STDScreenW ,100)
          collectionViewLayout:[self collectionViewFlowLayout]];
    
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
- (void)reloadCollectionWithImageUrls:(NSArray *)pointXList {
    self.pointXList = pointXList;
    [self reloadData];
}

- (void)p_configOwnProperties {
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}

- (BOOL)isRespondsDelegate {
//    return _imageDelegate &&
//    [_imageDelegate respondsToSelector:@selector(lessonPlanCollectionview:
//                                                 imageClickedWithIndex:
//                                                 imageType:)];
    return NO;
}

#pragma mark - CollectionViewFlowLayout
+ (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(100, 100);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 1;
    return layout;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.pointXList count];
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"DrawLineCollectionViewCell" forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    LessonPlanImage *lessonImage = self.imageUrls[indexPath.row];
    [(DrawLineCollectionViewCell *)cell configureCellWithPointXList:self.pointXList withIndex:indexPath.row];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if ([self isRespondsDelegate]) {
//        [_imageDelegate lessonPlanCollectionview:self
//                           imageClickedWithIndex:indexPath.row
//                                       imageType:_planType];
//    }
}

- (NSArray *)pointXList {
    if (_pointXList == nil) {
        _pointXList = @[@"12",@"23",@"57",@"23",@"54",@"56",@"97",@"34",@"3",@"76",@"35",@"73",@"27",@"23"];
    }
    return _pointXList;
}

@end
