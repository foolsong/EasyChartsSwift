//
//  DrawLineCollectionViewCell.h
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawLineCollectionViewCell : UICollectionViewCell

- (void)configureCellWithPointYList:(NSArray *)pointXList
                          withIndex:(NSInteger)index;

- (void)setItemSize:(CGSize)size;

- (void)setupCellSelected:(BOOL)selected;

@end
