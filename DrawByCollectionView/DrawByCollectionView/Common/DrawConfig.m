//  ************************************************************************
//
//  DrawConfig.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/8/29.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawConfig.h"

@interface DrawConfig ()

@property (nonatomic, assign) BrokenLineType brokenLineType;

@end

@implementation DrawConfig

+ (instancetype)drawConfigWithBrokenLineType:(BrokenLineType)brokenLineType {
    DrawConfig *drawConfig = [[DrawConfig alloc] init];
    drawConfig.brokenLineType = brokenLineType;
    return drawConfig;
}

- (UIColor *)brokenLineColor {
    if (_brokenLineColor == nil) {
        _brokenLineColor =
        self.brokenLineType == BrokenLineTypeMiddlePoint ?
                               [UIColor whiteColor]:
                               [UIColor colorWithRed:(37)/255.0
                                               green:(173)/255.0
                                                blue:(255)/255.0
                                               alpha:1.0];
    }
    return _brokenLineColor;
}

- (UIColor *)backVeiwLineColor {
    if (_backVeiwLineColor == nil) {
        _backVeiwLineColor = [UIColor colorWithRed:(239)/255.0
                                             green:(239)/255.0
                                              blue:(239)/255.0
                                             alpha:1.0];
    }
    return _backVeiwLineColor;
}

- (UIColor *)backVeiwTextColor {
    if (_backVeiwTextColor == nil) {
        _backVeiwTextColor = [UIColor colorWithRed:0.216
                                             green:0.204
                                              blue:0.478
                                             alpha:1.0];
    }
    return _backVeiwTextColor;
}

- (UIColor *)backVeiwBackGroupColor {
    if (_backVeiwBackGroupColor == nil) {
        _backVeiwBackGroupColor =
        self.brokenLineType == BrokenLineTypeMiddlePoint ?
        [UIColor colorWithRed:(255)/255.0 green:(209)/255.0 blue:(93)/255.0 alpha:1.0] :
        [UIColor whiteColor];
    }
    return _backVeiwBackGroupColor;
}

- (UIColor *)brokenAbscissaColor {
    if (_brokenAbscissaColor == nil) {
        _brokenAbscissaColor =
        self.brokenLineType == BrokenLineTypeMiddlePoint ?
        [UIColor colorWithRed:(255)/255.0 green:(209)/255.0 blue:(93)/255.0 alpha:0.8]:
        [UIColor colorWithRed:(150)/255.0 green:(150)/255.0 blue:(150)/255.0 alpha:0.8];
    }
    return _brokenAbscissaColor;
}

@end
