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

@property (nonatomic, strong) NSMutableArray *layerMutableList;

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
        [self drawCircleWithLineWidth:49
                            lineColor:[UIColor whiteColor]
                               radius:57
                               startA:model.startAngle
                                 endA:model.startAngle + 0.02];
    }
}

- (void)clearLayerList {
    for (CAShapeLayer *layer in self.layerMutableList) {
        [layer removeFromSuperlayer];
    }
    [self.layerMutableList removeAllObjects];
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
    [self.layerMutableList addObject:lineLayer];
    [self.layer addSublayer:lineLayer];
}

- (CAShapeLayer *)drawCircleWithLineWidth:(CGFloat )lineWidth
                                lineColor:(UIColor *)color
                                   radius:(CGFloat ) radius
                                   startA:(CGFloat ) startA
                                     endA:(CGFloat ) endA {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    CGPoint center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, 100);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.strokeColor = color.CGColor;
    [self.layerMutableList addObject:shapeLayer];
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}

-(NSMutableArray *)layerMutableList {
    if (_layerMutableList == nil) {
        _layerMutableList = [NSMutableArray array];
    }
    return _layerMutableList;
}

@end
