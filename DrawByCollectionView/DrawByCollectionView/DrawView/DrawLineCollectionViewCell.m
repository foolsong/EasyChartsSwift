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
#import "PointViewModel.h"

#define CIRCLE_SIZE 7.0

@interface DrawLineCollectionViewCell ()

@property (nonatomic, assign) CGSize size;

@property (nonatomic, copy) NSArray *pointYList;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) PointViewModel *pointModel;

@property (nonatomic, assign) CGContextRef context;

@property (nonatomic, strong) UIImage *circleImage;

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation DrawLineCollectionViewCell

- (void)configureCellWithPointYList:(NSArray *)pointYList
                          withIndex:(NSInteger)index {
    self.pointYList = pointYList;
    self.index = index;
    self.pointModel = self.pointYList[self.index];
    [self setBackgroundColor:[UIColor clearColor]];
    
    CGRect frame = self.circleLayer.frame;
    frame.origin.y = [self.pointModel.pointY floatValue] - 3.5;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
     [self.circleLayer setFrame: frame];
    [CATransaction commit];

    [self setNeedsDisplay];
}

- (void)setItemSize:(CGSize)size {
    _size = size;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    self.context = context;
    [self drawLeftLine];
    [self drawRightLine];
}

- (void)drawLeftLine {
    CGPoint firstPoint = CGPointMake(0, [self lastPointY]);
    CGPoint nextPoint = CGPointMake(self.size.width * 0.5, [self currentPointY]);
    if (self.pointModel.leftLineType == LineTypeNormal) {
        [self drawNormalLineFirstPoint:firstPoint nextPoint:nextPoint];
    } else if (self.pointModel.leftLineType == LineTypeDotted) {
        [self drawDottedLineFirstPoint:firstPoint nextPoint:nextPoint];
    }
}

- (void)drawRightLine {
    CGPoint firstPoint = CGPointMake(self.size.width * 0.5, [self currentPointY]);
    CGPoint nextPoint = CGPointMake(self.size.width, [self nextPointY]);
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
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(self.context, kCGPathStroke);
}

- (void)drawDottedLineFirstPoint:(CGPoint)point nextPoint:(CGPoint)nextPoint {
    // 设置线条的样式
    CGContextSetLineCap(self.context, kCGLineCapRound);
    // 绘制线的宽度
    CGContextSetLineWidth(self.context, 1.5);
    // 线的颜色
    CGContextSetStrokeColorWithColor(self.context, [UIColor whiteColor].CGColor);
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

- (CGFloat)currentPointY {
    return [self.pointModel.pointY floatValue];
}

- (CGFloat)nextPointY {
    if (self.index + 1 >= [self.pointYList count]) {
        return 0;
    }
    PointViewModel *pointModel = self.pointYList[self.index + 1];
    return ([pointModel.pointY floatValue] + [self currentPointY]) * 0.5;
}

- (CGFloat)lastPointY {
    if (self.index - 1 < 0) {
        return 0;
    }
    PointViewModel *pointModel = self.pointYList[self.index - 1];
    return ([pointModel.pointY floatValue] + [self currentPointY]) * 0.5;
}


- (CAShapeLayer*)circleLayer{
    if (_circleLayer == nil) {
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        UIImage *img = [self circleImage];
        [circleLayer setContents:(id)img.CGImage];
        [circleLayer setFrame:CGRectMake(self.size.width * 0.5 - 3.5,[self.pointModel.pointY floatValue] - 3.5, img.size.width, img.size.height)];
        [circleLayer setGeometryFlipped:YES];
        [circleLayer setLineJoin:kCALineJoinBevel];
        _circleLayer = circleLayer;
        [self.layer addSublayer:_circleLayer];
    }
    return _circleLayer;
}

- (UIImage*)circleImage{
    if(!_circleImage){
        CGSize imageSize = CGSizeMake(CIRCLE_SIZE, CIRCLE_SIZE);
        CGFloat strokeWidth = 1.5;
        
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);//[UIImage imageNamed:@"circle"];
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        [[UIColor clearColor] setFill];
        CGContextFillRect(context, (CGRect){CGPointZero, imageSize});
        
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: (CGRect){CGPointMake(strokeWidth/2.0, strokeWidth/2.0),
            CGSizeMake(CIRCLE_SIZE-strokeWidth, CIRCLE_SIZE-strokeWidth)}];
        
        CGContextSaveGState(context);
        //yjSong 圆圈填充
        UIColor *color = [UIColor colorWithRed:(255)/255.0 green:(209)/255.0 blue:(93)/255.0 alpha:1.0];
              [color setFill];
        
        [ovalPath fill];
        CGContextRestoreGState(context);
        
        //yjSong 圆圈边框
        [[UIColor whiteColor] setStroke];
        [ovalPath setLineWidth:strokeWidth];
        [ovalPath stroke];
        
        _circleImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return _circleImage;
}

@end
