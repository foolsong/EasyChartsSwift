//
//  DrawLineCollectionView.h
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrawLineCollectionView;
@protocol DrawLineCollectionViewDataSource <NSObject>

- (NSArray *)collectionViewPointYList:(DrawLineCollectionView *)collectionView;
- (CGSize)collectionView:(UICollectionView *)collectionView
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DrawLineCollectionView : UICollectionView

@property (nonatomic, weak) id<DrawLineCollectionViewDataSource> drawLineDataSource;
+ (instancetype)collectionView;

@end

@interface DrawLineCollectionViewFlowLayout : UICollectionViewFlowLayout

@end
