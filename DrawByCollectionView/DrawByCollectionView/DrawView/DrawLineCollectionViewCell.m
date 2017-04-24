//  ************************************************************************
//
//  DrawLineCollectionViewCell.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawLineCollectionViewCell.h"

@interface DrawLineCollectionViewCell ()

@property (nonatomic, copy) NSArray *pointXList;
@property (nonatomic, assign) NSInteger index;

@end

@implementation DrawLineCollectionViewCell

- (void)configureCellWithPointXList:(NSArray *)pointXList
                          withIndex:(NSInteger)index {
    self.pointXList = pointXList;
    self.index = index;
    UIColor *color = [UIColor colorWithRed:arc4random_uniform(255) / 255.0
                                     green:arc4random_uniform(255) / 255.0
                                      blue:arc4random_uniform(255) / 255.0
                                     alpha:1];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self layoutIfNeeded];
}

- (void)drawRect:(CGRect)rect {
    if (self.index == 0) {
        [self firstPointDraw];
    } else if (self.index == [self.pointXList count] - 1) {
        [self lastPointDraw];
    } else {
        [self normalPointDraw];
    }
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
    CGContextAddLineToPoint(context, 100, [self currentPointY]);
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
    return [self.pointXList[self.index] floatValue];
}

- (CGFloat)nextPointY {
    return ([self.pointXList[self.index + 1] floatValue] + [self currentPointY]) * 0.5;
}

- (CGFloat)lastPointY {
    return ([self.pointXList[self.index - 1] floatValue] + [self currentPointY]) * 0.5;
}

@end
