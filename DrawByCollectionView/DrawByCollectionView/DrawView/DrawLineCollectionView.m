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
#import "PointViewModel.h"

#define STDScreenW [UIScreen mainScreen].bounds.size.width

@interface DrawLineCollectionView ()<UICollectionViewDelegate,
                                   UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *pointXList;

@property (nonatomic, strong) NSMutableArray <PointViewModel *>*pointModelLits;

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

#pragma mark - CollectionViewFlowLayout
+ (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(100, 100);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 2;
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
    [(DrawLineCollectionViewCell *)cell configureCellWithPointXList:self.pointModelLits withIndex:indexPath.row];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (NSArray *)pointXList {
    if (_pointXList == nil) {
        _pointXList = @[@"12",@"51",@"-1",@"73",@"27",@"63",@"12",@"51",@"-1",@"-1",@"27",@"93"];
    }
    return _pointXList;
}


- (NSMutableArray<PointViewModel *> *)pointModelLits {
    if (_pointModelLits == nil) {
        _pointModelLits = [NSMutableArray array];
        [self test];
    }
    return _pointModelLits;
}

#pragma mark - 
- (void)test {
    for (int i = 0; i < [self.pointXList count]; i++) {
        NSString *numString = self.pointXList[i];
        NSString *lastNumString = [self numStringWithIndex:i - 1];
        NSString *nextNumString = [self numStringWithIndex:i + 1];;
        
        PointViewModel *pointModel = [[PointViewModel alloc] init];
        pointModel.leftLineType = [self lineTypeWithNumString:numString nearNumString:lastNumString];
        pointModel.rightLineType = [self lineTypeWithNumString:numString nearNumString:nextNumString];
        pointModel.pointX = [@"-1" isEqualToString:numString] ? @"99" : numString;
        
        [self.pointModelLits addObject:pointModel];
    }
}

- (NSString *)numStringWithIndex:(NSInteger)index {
    if (index < 0 || index >= [self.pointXList count]) {
        return nil;
    } else {
        return self.pointXList[index];
    }
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

@end
