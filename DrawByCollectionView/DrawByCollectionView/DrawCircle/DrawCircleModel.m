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

+ (instancetype)circleModelWithSrartAngle:(CGFloat)startAngle
                               arcPercent:(CGFloat) arcPercent
                                    color:(UIColor *)color {
    DrawCircleModel *model = [[self alloc] init];
    model.circleColor = color;
    model.arcPercent = arcPercent;
    model.startAngle = startAngle;
    [model computerEndAngle];
    [model computerArcCenterPoint];
    [model computerLinePoint];
    
    return model;
}

- (void)computerEndAngle {
    self.endAngle = _startAngle + 2 * M_PI * _arcPercent  - 0.02;
}

- (void)computerArcCenterPoint {
    CGFloat pointY = 100 + 76.5 * sin(_endAngle - (M_PI * _arcPercent));
    CGFloat pointX = ScreenW * 0.5 + 76.5 * cos(_endAngle - (M_PI * _arcPercent));
    self.arcCenterPoint = CGPointMake(pointX, pointY);
}

- (void)computerLinePoint {
    if (self.arcCenterPoint.x > ScreenW * 0.5  && self.arcCenterPoint.y < 100) {
        [self fourthQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantFourth;
    } else if (self.arcCenterPoint.x > ScreenW * 0.5  && self.arcCenterPoint.y > 100) {
        [self firstQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantFirst;
    } else  if (self.arcCenterPoint.x < ScreenW * 0.5  && self.arcCenterPoint.y > 100) {
        [self secondQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantSecond;
    } else {
        [self thirdQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantThird;
    }
}

- (void)firstQuadrant {
    self.textLeftCenterPoint = CGPointMake(ScreenW - 84, self.arcCenterPoint.y + 10);
    self.inflectionPoint = CGPointMake(self.arcCenterPoint.x + 10, self.textLeftCenterPoint.y);
}

- (void)secondQuadrant {
    self.textLeftCenterPoint = CGPointMake(80, self.arcCenterPoint.y + 10);
    self.inflectionPoint = CGPointMake(self.arcCenterPoint.x - 10, self.textLeftCenterPoint.y);
}

- (void)thirdQuadrant {
    self.textLeftCenterPoint = CGPointMake(80, self.arcCenterPoint.y - 10);
    self.inflectionPoint = CGPointMake(self.arcCenterPoint.x - 10, self.textLeftCenterPoint.y);
}

- (void)fourthQuadrant {
    self.textLeftCenterPoint = CGPointMake(ScreenW - 84, self.arcCenterPoint.y - 10);
    self.inflectionPoint = CGPointMake(self.arcCenterPoint.x + 10, self.textLeftCenterPoint.y);
}
@end
