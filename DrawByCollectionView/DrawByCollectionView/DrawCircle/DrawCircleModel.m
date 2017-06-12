//  ************************************************************************
//
//  DrawCircleModel.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/10.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawCircleModel.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface DrawCircleModel ()

@end

@implementation DrawCircleModel

- (void)computerLinePoint {
    if (_offestX > ScreenW * 0.5  && _offestY < 100) {
        [self fourthQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantFourth;
    } else if (_offestX > ScreenW * 0.5  && _offestY > 100) {
        [self firstQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantFirst;
    } else  if (_offestX < ScreenW * 0.5  && _offestY > 100) {
        [self secondQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantSecond;
    } else {
        [self thirdQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantThird;
    }
}

- (void)firstQuadrant {
    self.textLeftCenterPoint = CGPointMake(ScreenW - 84, self.offestY + 10);
    self.inflectionPoint = CGPointMake(self.offestX + 10, self.textLeftCenterPoint.y);
}

- (void)secondQuadrant {
    self.textLeftCenterPoint = CGPointMake(40, self.offestY - 10);
    self.inflectionPoint = CGPointMake(self.offestX - 10, self.textLeftCenterPoint.y);
}

- (void)thirdQuadrant {
    self.textLeftCenterPoint = CGPointMake(40, self.offestY + 10);
    self.inflectionPoint = CGPointMake(self.offestX - 10, self.textLeftCenterPoint.y);
}

- (void)fourthQuadrant {
    self.textLeftCenterPoint = CGPointMake(ScreenW - 84, self.offestY - 10);
    self.inflectionPoint = CGPointMake(self.offestX + 10, self.textLeftCenterPoint.y);
}
@end
