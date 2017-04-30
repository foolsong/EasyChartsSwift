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
//    LessonPlanImage *lessonImage = self.imageUrls[indexPath.row];
    [(DrawLineCollectionViewCell *)cell configureCellWithPointXList:self.pointModelLits withIndex:indexPath.row];
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
        _pointXList = @[@"12",@"51",@"-1",@"73",@"27",@"23",@"12",@"51",@"-1",@"-1",@"27",@"23"];
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
    
    CGFloat offest = 0;
    for (int i = 0; i < [self.pointXList count]; i++) {
        NSString *numString = self.pointXList[i];
        NSString *lastNumString;
        NSString *nextNumString = nil;
        
        NSString *lastNum ;
        
        PointViewModel *pointModel = [[PointViewModel alloc] init];
        
        if (i - 1 < 0) {
            lastNumString = nil;
        } else {
            PointViewModel *pointModel = [self.pointModelLits lastObject];
            lastNumString = pointModel.pointX;
            lastNum = self.pointXList[i - 1];
        }
        
        if (i + 1 >= [self.pointXList count]) {
            nextNumString = nil;
        } else {
            nextNumString = self.pointXList[i + 1];
        }
        
        
        
        
        if (lastNumString == nil) {
            pointModel.leftLineType = LineTypeNoline;
        } else if ([@"-1" isEqualToString:lastNum] || [@"-1" isEqualToString:numString]) {
            pointModel.leftLineType = LineTypeDotted;
        } else {
            pointModel.leftLineType = LineTypeNormal;
        }
        
        
        
        if (offest == 0) {
            pointModel.pointX = numString;
            [self.pointModelLits addObject:pointModel];
        } else {
            pointModel.pointX = [NSString stringWithFormat:@"%.0f",[lastNumString integerValue] + offest];
            [self.pointModelLits addObject:pointModel];
        }
        
        if (nextNumString == nil) {
            offest = 0;
            pointModel.rightLineType = LineTypeNoline;
        } else if ([@"-1" isEqualToString:nextNumString]  || [@"-1" isEqualToString:numString]) {
            pointModel.rightLineType = LineTypeDotted;
        } else {
            offest = 0;
            pointModel.rightLineType = LineTypeNormal;
        }
        
        if (offest == 0 &&  [@"-1" isEqualToString:nextNumString]) {
            CGFloat num = 1;
            for (int j = i + 1 ; [self.pointXList count]; j++) {
                if ([@"-1" isEqualToString:self.pointXList[j]]) {
                    num ++;
                } else {
                    offest = ([self.pointXList[j] integerValue] - [numString integerValue]) / num;
                    break;
                }
            }
        }
        
    }
    
    NSLog(@"%@",self.pointModelLits);
    
}

@end
