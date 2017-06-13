//  ************************************************************************
//
//  DrawCircleLineView.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/12.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawCircleLineView.h"
#import "DrawCircleModel.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface DrawCircleLineView ()



@end

@implementation DrawCircleLineView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setupLabel:(DrawCircleModel *)model {
    CGRect frame;
    if (model.arcCenterQuadrant == ArcCenterQuadrantFourth || model.arcCenterQuadrant == ArcCenterQuadrantFirst) {
        frame = CGRectMake(model.textLeftCenterPoint.x + 4, model.textLeftCenterPoint.y - 11, 32, 22);
    } else {
        frame = CGRectMake(model.textLeftCenterPoint.x + 4 - 32, model.textLeftCenterPoint.y - 11, 32, 22);

    }
    
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:13]];
    label.frame = frame;
    [label setText:@"掌握"];
    [label setTextColor:model.circleColor];
    [self addSubview:label];
}

- (void)resetLine:(NSArray *)circleModelList {
    for (int i = 0; i < [circleModelList count]; i ++) {
        DrawCircleModel *model = circleModelList[i];
        [self drawLine:model];
        [self setupLabel:model];
    }
}

- (void)drawLine:(DrawCircleModel *)model{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:model.textLeftCenterPoint];
    // 其他点
    [linePath addLineToPoint:model.inflectionPoint];
    [linePath addLineToPoint:model.arcCenterPoint];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    
    lineLayer.lineWidth = ((1 / [UIScreen mainScreen].scale) / 2);
    lineLayer.strokeColor = model.circleColor.CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    
    [self.layer addSublayer:lineLayer];
}

@end
