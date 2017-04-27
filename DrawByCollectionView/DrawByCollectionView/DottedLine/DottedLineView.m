//  ************************************************************************
//
//  DottedLineView.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/4/27.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DottedLineView.h"

@interface DottedLineView ()



@end

@implementation DottedLineView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect { // 可以通过 setNeedsDisplay 方法调用 drawRect:
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddLineToPoint(context, 50, 80);
    CGContextAddLineToPoint(context, 100,20);
    [[UIColor orangeColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
    
    
    
    
    
    
    
    // 设置线条的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 绘制线的宽度
    CGContextSetLineWidth(context, 1.0);
    // 线的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    // 开始绘制
    CGContextBeginPath(context);
    // 设置虚线绘制起点
    CGContextMoveToPoint(context, 10.0, 20.0);
    // lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复
    CGFloat lengths[] = {10,10};
    // 虚线的起始点
    CGContextSetLineDash(context, 0, lengths,2);
    // 绘制虚线的终点
    CGContextAddLineToPoint(context, 310.0,20.0);
    // 绘制
    CGContextStrokePath(context);
    
    
    // 关闭图像
    CGContextClosePath(context);
    
}

@end
