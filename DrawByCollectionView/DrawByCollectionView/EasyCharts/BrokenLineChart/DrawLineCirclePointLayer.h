//
//  DrawLineCirclePointLayer.h
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/8.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class ECBrokenLineConfig;
@interface DrawLineCirclePointLayer : CAShapeLayer

+ (instancetype)circlePointLayerWithBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig;
+ (instancetype)circlePointSelectedLayerWithBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig;

@end
