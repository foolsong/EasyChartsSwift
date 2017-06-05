//  ************************************************************************
//
//  DrawLineCollectionViewCell.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function: 好好学de 习
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawLineCollectionViewCell.h"
#import "PointViewModel.h"

@interface DrawLineCollectionViewCell ()

@property (nonatomic, copy) NSArray *pointXList;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) PointViewModel *pointModel;

@property (nonatomic, assign) CGContextRef context;

@end

@implementation DrawLineCollectionViewCell

- (void)configureCellWithPointXList:(NSArray *)pointXList
                          withIndex:(NSInteger)index {
    self.pointXList = pointXList;
    self.index = index;
    self.pointModel = self.pointXList[self.index];
//    UIColor *color = [UIColor colorWithRed:arc4random_uniform(255) / 255.0
//                                     green:arc4random_uniform(255) / 255.0
//                                      blue:arc4random_uniform(255) / 255.0
//                                     alpha:1];
    [self setBackgroundColor:[UIColor grayColor]];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
//    if (self.index == 0) {
//        [self firstPointDraw];
//    } else if (self.index == [self.pointXList count] - 1) {
//        [self lastPointDraw];
//    } else {
//        [self normalPointDraw];
//    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    self.context = context;
    [self drawLeftLine];
    [self drawRightLine];
}

- (void)drawLeftLine {
    CGPoint firstPoint = CGPointMake(0, [self lastPointY]);
    CGPoint nextPoint = CGPointMake(50, [self currentPointY]);
    if (self.pointModel.leftLineType == LineTypeNormal) {
        [self drawNormalLineFirstPoint:firstPoint nextPoint:nextPoint];
    } else if (self.pointModel.leftLineType == LineTypeDotted) {
        [self drawDottedLineFirstPoint:firstPoint nextPoint:nextPoint];
    }
}

- (void)drawRightLine {
    CGPoint firstPoint = CGPointMake(50, [self currentPointY]);
    CGPoint nextPoint = CGPointMake(100, [self nextPointY]);
    if (self.pointModel.rightLineType == LineTypeNormal) {
        [self drawNormalLineFirstPoint:firstPoint nextPoint:nextPoint];
    } else if (self.pointModel.rightLineType == LineTypeDotted) {
        [self drawDottedLineFirstPoint:firstPoint nextPoint:nextPoint];
    }
}

- (void)drawNormalLineFirstPoint:(CGPoint)point nextPoint:(CGPoint)nextPoint {
    
    CGFloat lengths[] = {10,0};
    // 虚线的起始点
    CGContextSetLineDash(self.context, 0, lengths,2);
    
    CGContextMoveToPoint(self.context, point.x, point.y);
    CGContextAddLineToPoint(self.context, nextPoint.x, nextPoint.y);
    [[UIColor orangeColor] setStroke];
    CGContextDrawPath(self.context, kCGPathStroke);
}

- (void)drawDottedLineFirstPoint:(CGPoint)point nextPoint:(CGPoint)nextPoint {
    // 设置线条的样式
    CGContextSetLineCap(self.context, kCGLineCapRound);
    // 绘制线的宽度
    CGContextSetLineWidth(self.context, 1.0);
    // 线的颜色
    CGContextSetStrokeColorWithColor(self.context, [UIColor orangeColor].CGColor);
    // 开始绘制
    CGContextBeginPath(self.context);
    // 设置虚线绘制起点
    CGContextMoveToPoint(self.context, point.x, point.y);
    // lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复
    CGFloat lengths[] = {5,5};
    // 虚线的起始点
    CGContextSetLineDash(self.context, 0, lengths,2);
    // 绘制虚线的终点
    CGContextAddLineToPoint(self.context, nextPoint.x,nextPoint.y);
    // 绘制
    CGContextStrokePath(self.context);
    
    
    // 关闭图像
    CGContextClosePath(self.context);
}

- (void)firstPointDraw {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 50, [self currentPointY]);
    CGContextAddLineToPoint(context, 100, [self nextPointY]);
    [[UIColor orangeColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)lastPointDraw {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, [self lastPointY]);
    CGContextAddLineToPoint(context, 50, [self currentPointY]);
    [[UIColor orangeColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)normalPointDraw {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, [self lastPointY]);
    CGContextAddLineToPoint(context, 50, [self currentPointY]);
    CGContextAddLineToPoint(context, 100, [self nextPointY]);
    [[UIColor orangeColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
}


- (CGFloat)currentPointY {
    return [self.pointModel.pointY floatValue];
}

- (CGFloat)nextPointY {
    if (self.index + 1 >= [self.pointXList count]) {
        return 0;
    }
    PointViewModel *pointModel = self.pointXList[self.index + 1];
    return ([pointModel.pointY floatValue] + [self currentPointY]) * 0.5;
}

- (CGFloat)lastPointY {
    if (self.index - 1 < 0) {
        return 0;
    }
    PointViewModel *pointModel = self.pointXList[self.index - 1];
    return ([pointModel.pointY floatValue] + [self currentPointY]) * 0.5;
}

@end
