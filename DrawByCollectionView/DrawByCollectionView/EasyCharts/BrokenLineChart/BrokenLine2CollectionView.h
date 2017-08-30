//
//  BrokenLine2CollectionViewController.h
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/8/26.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface BrokenLine2CollectionViewController : UICollectionViewController
//
//@end


@class BrokenLine2CollectionView,ECBrokenLineConfig;
@protocol BrokenLine2CollectionViewDataSource <NSObject>

- (NSArray *)collectionViewPointYList:(BrokenLine2CollectionView *)collectionView;
- (CGSize)collectionView:(BrokenLine2CollectionView *)collectionView
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol BrokenLine2CollectionViewDelegate <NSObject>

- (void)collectionViewPointYList:(BrokenLine2CollectionView *)collectionView
        didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BrokenLine2CollectionView : UICollectionView

@property (nonatomic, weak) id<BrokenLine2CollectionViewDataSource> drawLineDataSource;
@property (nonatomic, weak) id<BrokenLine2CollectionViewDelegate> drawLineDelegate;

+ (instancetype)collectionViewWithFrame:(CGRect)frame
                   withBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig;
- (void)reloadCollectionData;

@end


typedef  void (^ScrollIndexBlock)(NSInteger);

@interface BrokenLine2CollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, copy) ScrollIndexBlock indexBlock;

@end
