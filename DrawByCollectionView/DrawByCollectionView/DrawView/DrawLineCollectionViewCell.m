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

#import "DrawLineCirclePointLayer.h"

#define CIRCLE_SIZE 7.0

@interface DrawLineCollectionViewCell ()

@property (nonatomic, assign) CGSize cellSize;

@property (nonatomic, copy) NSArray *pointYList;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) PointViewModel *pointModel;

@property (nonatomic, assign) CGContextRef context;

@property (nonatomic, strong) UIImage *circleImage;

@property (nonatomic, strong) DrawLineCirclePointLayer *circleLayer;

@end

@implementation DrawLineCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setupNumLabel];
    }
    return self;
}

- (void)configureCellWithPointYList:(NSArray *)pointYList
                          withIndex:(NSInteger)index {
    self.pointYList = pointYList;
    self.index = index;
    self.pointModel = self.pointYList[self.index];
    
    [self resetCircleLayerFrame];
    [self setNeedsDisplay];
}

- (void)resetCircleLayerFrame {
    CGRect frame = self.circleLayer.frame;
    frame.origin.y = [self.pointModel.pointY floatValue] - 4.25;
    frame.origin.x = self.cellSize.width * 0.5 - 4.25;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.circleLayer setFrame: frame];
    [CATransaction commit];
}

- (void)setItemSize:(CGSize)size {
    _cellSize = size;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    self.context = context;
    [self drawLeftLine];
    [self drawRightLine];
}

- (void)drawLeftLine {
    CGPoint firstPoint = CGPointMake(0, [self lastPointY]);
    CGPoint nextPoint = CGPointMake(self.cellSize.width * 0.5, [self currentPointY]);
    if (self.pointModel.leftLineType == LineTypeNormal) {
        [self drawNormalLineFirstPoint:firstPoint nextPoint:nextPoint];
    } else if (self.pointModel.leftLineType == LineTypeDotted) {
        [self drawDottedLineFirstPoint:firstPoint nextPoint:nextPoint];
    }
}

- (void)drawRightLine {
    CGPoint firstPoint = CGPointMake(self.cellSize.width * 0.5, [self currentPointY]);
    CGPoint nextPoint = CGPointMake(self.cellSize.width, [self nextPointY]);
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


- (DrawLineCirclePointLayer *)circleLayer {
    if (_circleLayer == nil) {
        _circleLayer = [DrawLineCirclePointLayer circlePointLayer];
        [self.layer addSublayer:_circleLayer];
    }
    return _circleLayer;
}

- (void)setupNumLabel {
    UILabel *datelabel = [[UILabel alloc] init];
    [datelabel setText:@"12.12~12.19"];
    datelabel.textAlignment = NSTextAlignmentCenter;
    datelabel.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20);
    [datelabel setFont:[UIFont systemFontOfSize:11]];
    [datelabel setTextColor:[UIColor colorWithRed:(255)/255.0 green:(209)/255.0 blue:(93)/255.0 alpha:0.8]];
    [self addSubview:datelabel];
}

@end
