//
//  BrokenLineBackgroundView.h
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/8/26.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrawConfig;
@interface BrokenLineBackgroundView : UIView

+ (instancetype)lineBackgroundViewWithFrame:(CGRect)frame
                             withDrawConfig:(DrawConfig *)drawConfig;

@end
