//
//  ECBrokenLineCenterCollectionView.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECBrokenLineCenterCollectionView,ECBrokenLineConfig;
@protocol DrawLineCollectionViewDataSource <NSObject>

- (NSArray *)collectionViewPointYList:(ECBrokenLineCenterCollectionView *)collectionView;
- (CGSize)collectionView:(UICollectionView *)collectionView
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol DrawLineCollectionViewDelegate <NSObject>

- (void)collectionViewPointYList:(ECBrokenLineCenterCollectionView *)collectionView
        didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ECBrokenLineCenterCollectionView : UICollectionView

@property (nonatomic, weak) id<DrawLineCollectionViewDataSource> drawLineDataSource;
@property (nonatomic, weak) id<DrawLineCollectionViewDelegate> drawLineDelegate;
+ (instancetype)collectionViewWithFrame:(CGRect)frame
                         withDrawConfig:(ECBrokenLineConfig *)brokenLineConfig;
- (void)reloadCollectionData;

@end


typedef  void (^ScrollIndexBlock)(NSInteger);

@interface DrawLineCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, copy) ScrollIndexBlock indexBlock;

@end