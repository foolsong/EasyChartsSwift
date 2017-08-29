//
//  DrawLineCollectionView.h
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrawLineCollectionView,DrawConfig;
@protocol DrawLineCollectionViewDataSource <NSObject>

- (NSArray *)collectionViewPointYList:(DrawLineCollectionView *)collectionView;
- (CGSize)collectionView:(UICollectionView *)collectionView
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol DrawLineCollectionViewDelegate <NSObject>

- (void)collectionViewPointYList:(DrawLineCollectionView *)collectionView
        didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DrawLineCollectionView : UICollectionView

@property (nonatomic, weak) id<DrawLineCollectionViewDataSource> drawLineDataSource;
@property (nonatomic, weak) id<DrawLineCollectionViewDelegate> drawLineDelegate;
+ (instancetype)collectionViewWithFrame:(CGRect)frame
                         withDrawConfig:(DrawConfig *)drawConfig;
- (void)reloadCollectionData;

@end


typedef  void (^ScrollIndexBlock)(NSInteger);

@interface DrawLineCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, copy) ScrollIndexBlock indexBlock;

@end
