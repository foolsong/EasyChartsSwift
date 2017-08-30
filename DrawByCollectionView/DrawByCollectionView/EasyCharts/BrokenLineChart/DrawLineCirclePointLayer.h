//
//  DrawLineCirclePointLayer.h
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/8.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class DrawConfig;
@interface DrawLineCirclePointLayer : CAShapeLayer

+ (instancetype)circlePointLayerWithDrawConfig:(DrawConfig *)drawConfig;
+ (instancetype)circlePointSelectedLayerWithDrawConfig:(DrawConfig *)drawConfig;

@end
