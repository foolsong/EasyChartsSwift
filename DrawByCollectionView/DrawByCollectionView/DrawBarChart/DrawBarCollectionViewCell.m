//  ************************************************************************
//
//  DrawBarCollectionViewCell.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/9.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawBarCollectionViewCell.h"

@interface DrawBarCollectionViewCell()

@property (nonatomic, strong) CAShapeLayer *totalPointsLayer;
@property (nonatomic, strong) CAShapeLayer *highFrequencyLayer;

@end

@implementation DrawBarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor grayColor]];
        
    }
    return self;
}

- (void)reset {
    [self p_addBarLayerToLayer];
}


- (void)p_addBarLayerToLayer {
    CGFloat centerX = self.frame.size.width / 2.0;
    //    CGFloat margin = (iPhone5 ? (14 + 30) * PICTURE_SCALE : (14 + 30)) / 4.0;
    CGFloat margin = 15;
    
    
    
    self.totalPointsLayer   = [self generateMaskLayerWithColor:[UIColor orangeColor]
                                                             x:(centerX - margin)
                                                        height:120 * (arc4random_uniform(100) / 100.0) / 2.0
                                                    percentage:0.5];
    self.highFrequencyLayer = [self generateMaskLayerWithColor:[UIColor blueColor]
                                                             x:(centerX + margin)
                                                        height:120 * (arc4random_uniform(100) / 100.0) / 2.0
                                                    percentage:0.3];
    
    [self.contentView.layer addSublayer:self.totalPointsLayer];
    [self.contentView.layer addSublayer:self.highFrequencyLayer];
}

- (CAShapeLayer *)generateMaskLayerWithColor:(UIColor *)color
                                           x:(CGFloat)x
                                      height:(CGFloat)height
                                  percentage:(CGFloat)percentage{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    CGFloat lineWidth = 30 * 1 / 2.0;
    
    UIBezierPath *bar = [UIBezierPath bezierPath];
    [bar moveToPoint:CGPointMake(x, 200)];
    [bar addLineToPoint:CGPointMake(x, height)];
    
    layer.path = bar.CGPath;
    layer.lineWidth = lineWidth;
    layer.fillColor = color.CGColor;
    layer.strokeColor = color.CGColor;
    layer.lineCap = kCALineCapButt;
    
    return layer;
}


@end
